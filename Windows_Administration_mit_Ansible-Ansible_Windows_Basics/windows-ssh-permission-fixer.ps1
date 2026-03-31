icacls C:\Users\labadmin\.ssh /inheritance:r
icacls C:\Users\labadmin\.ssh /grant "labadmin:(OI)(CI)F" "SYSTEM:(OI)(CI)F"
icacls C:\Users\labadmin\.ssh\authorized_keys /inheritance:r
icacls C:\Users\labadmin\.ssh\authorized_keys /grant "labadmin:F" "SYSTEM:F"