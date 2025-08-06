# Host Feature Implementation Summary

## Overview
This implementation adds support for specifying a host when setting up and updating DNS records. Users can now use commands like:
```bash
domainconnectddns-python setup --domain kato1304.de --host '*'
```

## Changes Made

### 1. Command Line Interface (`dyndns/command_line.py`)
- Added `--host` parameter with default value `'@'` (for root domain)
- Updated function calls to pass host parameter to all domain operations
- Added `create_parser()` function for better testability

### 2. Domain Setup (`dyndns/domain_setup.py`)
- Modified `main()` function to accept `host` parameter (default: `'@'`)
- Updated Domain Connect template parameters to include `HOST` parameter
- Store host information in settings file for future reference

### 3. Domain Update (`dyndns/domain_update.py`)
- Modified `main()` function to accept `host` parameter (default: `'@'`)
- Updated DNS resolution to use host parameter when querying records
- Updated Domain Connect template application to include host parameter

### 4. Domain Status (`dyndns/domain_status.py`)
- Modified `main()` function to accept `host` parameter (default: `'@'`)
- Added host information to status display

## Usage Examples

### Setup with specific host
```bash
domainconnectddns-python setup --domain kato1304.de --host '*'
```

### Setup with subdomain
```bash
domainconnectddns-python setup --domain kato1304.de --host 'www'
```

### Update with host
```bash
domainconnectddns-python update --domain kato1304.de --host '*'
```

### Status with host
```bash
domainconnectddns-python status --domain kato1304.de --host '*'
```

## Technical Details

### Host Parameter Values
- `'@'` (default): Root domain (e.g., `kato1304.de`)
- `'*'`: Wildcard subdomain (e.g., `*.kato1304.de`)
- `'www'`: Specific subdomain (e.g., `www.kato1304.de`)
- Any other string: Custom subdomain

### DNS Resolution
When a host is specified:
- For `'@'`: Queries the domain directly
- For other hosts: Queries `{host}.{domain}` (e.g., `*.kato1304.de`)

### Settings Storage
The host information is stored in the settings file:
```json
{
  "kato1304.de": {
    "provider_name": "...",
    "url_api": "...",
    "access_token": "...",
    "refresh_token": "...",
    "iat": "...",
    "access_token_expires_in": "...",
    "protocols": ["IPv4", "IPv6"],
    "host": "*"
  }
}
```

## Backward Compatibility
- All existing functionality remains unchanged
- Default host value `'@'` ensures existing configurations continue to work
- No breaking changes to existing API or command line interface

## Testing
A test script (`test_host_feature.py`) is provided to verify:
- Command line argument parsing
- Function signatures
- Default parameter values 