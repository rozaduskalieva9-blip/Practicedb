using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Task28_sql
{
    internal class Program
    {
        static async Task  Main(string[] args)
        {
            // Устанавливаем переменную окружения прямо в коде (работает мгновенно и без настроек Windows)
            Environment.SetEnvironmentVariable("PRACTICE_DB_CONNECTION", "Server=localhost;Database=PracticeDB;Trusted_Connection=True;TrustServerCertificate=True;");

            // 1. Получаем строку подключения из переменной окружения (как требует задание)
            string connectionString = Environment.GetEnvironmentVariable("PRACTICE_DB_CONNECTION");

            if (string.IsNullOrEmpty(connectionString))
            {
                Console.WriteLine("Ошибка: Переменная окружения PRACTICE_DB_CONNECTION не задана.");
                return;
            }

            // Требуемый SQL-запрос
            string query = "SELECT EmployeeName, Salary FROM Employees;";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // 2. Асинхронное открытие соединения
                    await connection.OpenAsync();
                    Console.WriteLine("Успешное подключение к базе данных PracticeDB!\n");

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // 3. Вывод данных через SqlDataReader
                        using (SqlDataReader reader = await command.ExecuteReaderAsync())
                        {
                            Console.WriteLine($"{"Имя сотрудника",-25} | {"Зарплата",-10}");
                            Console.WriteLine(new string('-', 40));

                            while (await reader.ReadAsync())
                            {
                                string name = reader["EmployeeName"].ToString();
                                decimal salary = reader.GetDecimal(reader.GetOrdinal("Salary"));

                                Console.WriteLine($"{name,-25} | {salary,10:N2}");
                            }
                        }
                    }
                }
            }
            // 4. Обработка SqlException
            catch (SqlException ex)
            {
                Console.WriteLine($"Ошибка базы данных (SQL Exception): {ex.Message}");
                Console.WriteLine($"Код ошибки: {ex.Number}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Произошла непредвиденная ошибка: {ex.Message}");
            }
        }
    }
}