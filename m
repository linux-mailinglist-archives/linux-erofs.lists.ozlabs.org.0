Return-Path: <linux-erofs+bounces-571-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFFAAFE1B4
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Jul 2025 09:59:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcVkJ0b6mz2ydj;
	Wed,  9 Jul 2025 17:59:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c408::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752047976;
	cv=pass; b=WnJKqo3M8RI7bnoGJhCTYW64WWCMKI6eSn+E6L2CYU5OpB2OOuhFPT5QSZUwyoOBf7XpHRGXeOB8upHdxu709HYIVH7AAlaimFEwLnYIkNICdMq+r2u3VZJf++Q/OxXSNTdmoF/APDOowJIeeAK7MIwwBYIfkXoTI/1QncTz0aXOpZk6iEB/fBFAEtuskVWmi4yzZZMMQF/MKwuGWhq6LQTgsrOk6ZLogEkCg2Xfcq3Iy5FOnpa1xU1NFoJEFyVgS2swGA5lprvsQVjiWFOBvwb/CFPXDbRvqOdPFwX5adsL/Dd/gK1cjwtEukXtBjqqTFNw8hKaePTEiaax4xGBVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752047976; c=relaxed/relaxed;
	bh=GoH1iGwoKFhuUVhvgjq1UZwiIIrBqlAlYvhrar/wI7w=;
	h=Content-Type:From:To:Subject:Date:Message-ID:MIME-Version; b=Lrkrq5zsmhbXREU3EwaQ6L9GI86WcezRHch7eWe89EhhC40PeBHxh6cp6GteP1t0VDn0yZnPnyDNvznodys4Wuq0gxNfcSiWSvmT94+9J9OmkBAh40i1FM4wkdHfVQ0udcn9sVgeAWem8UJrcmKNSJSf+M8yfHfJm2NXvPT3Ji0oCIeLLjc0W7gE9BZRwEluNeboIPwQ6lQsHmWO346Z3P5r7DilIzf11ILy37JXad9tYGfz7CzXA7BCIMydLbcw6NbczrBd1eSitP/przdpSHxLrwQA+JJXLyT2KMkYfNRTSnyfCt7xYptwjoJ92PYAUdPJJYHJItl5iUenpPlqEA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=occurence.xyz; spf=pass (client-ip=2a01:111:f403:c408::3; helo=pnzpr01cu001.outbound.protection.outlook.com; envelope-from=charlotte.daniel@occurence.xyz; receiver=lists.ozlabs.org) smtp.mailfrom=occurence.xyz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=occurence.xyz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=occurence.xyz (client-ip=2a01:111:f403:c408::3; helo=pnzpr01cu001.outbound.protection.outlook.com; envelope-from=charlotte.daniel@occurence.xyz; receiver=lists.ozlabs.org)
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcVkH1cRsz2xjP
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 17:59:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU6ug2PvnpVPYEBl1nfuQs2EjbpJgK9L27G0z3yzHyITOJMzan9GUbbd2Ch80YIcA+FqKZyEjHnAlI4X3mw7rkGVNNVjgDESh1rJRJrZ5IVxmdqHar8a3MayMhAItpXbG+XEmkQ2up/M5GvP9y3A9XgFW612SXajpk5D+qR5yQeJYMYBTJa5Jx7x1v7rfK24sxCPpRVKdTl4NU5o0vedd5qe/AXfaAu4CUhLv7ZeUMEbEUrIu/w8P+flVoDdCHcNXNVmngRRZJAAVTwgSeqECUME+eRYBFEIyHUq5PnPXqEmRQpNmHomN10oKPuXofCGxSR3M6PmxybQ8qIdmf8KeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoH1iGwoKFhuUVhvgjq1UZwiIIrBqlAlYvhrar/wI7w=;
 b=g5t+TGNfxcO2hfMW0/vAh5W5cnCfwh5rcVILsgDaluTUMqNWIdZQcFH80QKHUp2qbA024pLM0/Y3Fk0xg6kqPJYSN1c+KtTCWUjQ3yMSktDMxy+bXXicgOxaU7cVbG3QfuAzWH36eP3GjhSIxSOu3HH7Ohi4E8uOK+DQwaoGwDTNFeB7Nu8fSs063zne44Hl4PrxjcmYIY+KmD2/UDcIMlYPJ1eeiywLg7oAdx6uzEOWBAvaNOMK3/MWXllinAVDZbcwc2wlrK7TsB2RkBmmXTugDhuDogUStIBa/C2o4WsiWwoeGmm1HXPO0Ck/O5tALF0aqum2+U6fgUl7MQpX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=occurence.xyz; dmarc=pass action=none
 header.from=occurence.xyz; dkim=pass header.d=occurence.xyz; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=occurence.xyz;
Received: from PN2P287MB1981.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c6::6)
 by PN3P287MB1382.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 07:59:07 +0000
Received: from PN2P287MB1981.INDP287.PROD.OUTLOOK.COM
 ([fe80::da32:50a3:5f69:aea5]) by PN2P287MB1981.INDP287.PROD.OUTLOOK.COM
 ([fe80::da32:50a3:5f69:aea5%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:59:07 +0000
Content-Type: multipart/mixed; boundary="===============8602527088095563106=="
From: Charlotte Daniel <charlotte.daniel@occurence.xyz>
To: linux-erofs@lists.ozlabs.org
Subject: LIBRAMONT - Agriculture Forestry 2025
Date: Wed, 9 Jul 2025 07:59:07 +0000
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To PN2P287MB1981.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1c6::6)
Message-ID:
 <PN2P287MB19810E68B1FA612F87AA40959149A@PN2P287MB1981.INDP287.PROD.OUTLOOK.COM>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2P287MB1981:EE_|PN3P287MB1382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9204b789-1113-454c-2600-08ddbebe7b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|10070799003|4022899009|8096899003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDFObkczY0tCbUhvUDJGRHZucThYMnYwWVk3ZDA3b1A4YXB6QkhwUFZ3eGVk?=
 =?utf-8?B?ZmwxYTRlZndnOXIxSUh4eWZ1VzlhNnZVUy9PSHB5NzZ3TzNXL3c5QzRLc3NE?=
 =?utf-8?B?dmpnT2wxMkhQV2ozZ2VLTloraGNPc2s1Wi9uTCtqMEhiaXhlY1JyaWZURXp1?=
 =?utf-8?B?TXBZZEczZTVKa3NQZEUycWxDREtldmFDTHhxVWIvMTVSK2Y2ODFManQ0UWNR?=
 =?utf-8?B?QzdEVm1TWUsrbmwyNXZXaDNYejlEdDAyM2JIMmdqR2srYmIyQUFHNEFFQjFD?=
 =?utf-8?B?L0Z3dzVzOWlXdndPdDFodFpLN1ZhUHBVcUxwNzFTQ3FQLzV6ZndET3R2eXVM?=
 =?utf-8?B?VTIrVUdRMDdQa1F4aXlQenlsRTE2V1VPeWtUUjNlaUNsWDFLeGdJaWg2b045?=
 =?utf-8?B?UUF2d1JWRWZWUDNaOUF6K1lrOVFrOC90Q3FsNTd1SDlqWUtySGlWWE8rZERK?=
 =?utf-8?B?bWg2eEVLeVBRa2YrWTZIR1k0K0FVdmxPWXdHMzVuRFl5a3BIL0h1VmZEZjFI?=
 =?utf-8?B?N0pQZVNtcld2WHRkcko4ekFkbHg5WW13YXlBeTdSdVlTVWEwRXBtbDZjRUJY?=
 =?utf-8?B?ZEtacnN1NnBuMlZpWVJvZjFqU01pSmplUWoyYzRYVUZnRExqWFppWXpSMEFU?=
 =?utf-8?B?WlVvcnkybFYrTEROemZUN2RQZm53MVdjM0p2K0R3Z042cFkyTllmaDFONWlW?=
 =?utf-8?B?aEU0K2tmdUlrRHY1Y3c2V2p3U21hbjJkUTFWcXhQNlZFVTFYaDdhbXFPNmJC?=
 =?utf-8?B?NGlpRnBWSFRjZWh1V3ZiWFI5Q3VTdXNZR2xwT09ram96Kzk4U29UZ1NkQmdy?=
 =?utf-8?B?RTZucmxLcFR5Y3daZG5VWGdQc0JGNSsxMUE5ZUhUOVp4cjljOWcwcmFVS1F5?=
 =?utf-8?B?eVBmVjNKeUdIOVIyT3JyWUs2K0dWRU1zSDc1QW1zdExDVnFobVp3bFZSOWlO?=
 =?utf-8?B?SFBmT1F5QnZNUWt1N0F1ZU45SnBLMHp5SzJXSXFLbDd3Z0tzTUN6VElpdUJC?=
 =?utf-8?B?dDhLUGZEUmhXUkJOU0ZjS0JaVGI5UHpFWnlFNkVacUhtSHpvcXJZRkdSTWVv?=
 =?utf-8?B?Q0xaYWE3eVpiNy83a1JFczFNbVhMUmJZNSs3UVB3NzZzSk5mZjVvUjVPSWpR?=
 =?utf-8?B?aUZTMC91R1MxV01UNTFRUzlOa2FocmVDYjZuUFBjcnFDTGdQNDhKdC9jN1Vs?=
 =?utf-8?B?QysyVTZqeUowNlpIYk5iTWg3d1QybnZYTGFua3JBL1FMdHF5d2Nic3JTREQ0?=
 =?utf-8?B?V0tNdkNzN3BoWnFjMEJJVlVpQ1dJcE05VEFvaHlTVEovSWQ3K1R6dEN6dy8y?=
 =?utf-8?B?Y05JeXQwUFUybmV5bXczNS96aHdzaW55bi95WTVFNmRDSTV4cFg4OGx3azgv?=
 =?utf-8?B?VXJzdXBDNm0yTmVLaEpXQ04vZis4WW9DT09CVHZzaUZobnZtZWpCTEJjYmQx?=
 =?utf-8?B?ZWRrNkJyUmlCbElldFVTYXJQR0k2bTNMTUV4UkM2WFJxcGUxZC9iWWEzY2F1?=
 =?utf-8?B?Qmt6c3VUcmdoVm5BNVdrZW0zdlI1NFZNZEx0UnZ0QkxjR3gvQm5VVlZHN0tu?=
 =?utf-8?B?Q2Yyd0xsbGtjbk1Ec1JRajQ2dDE1MlErZGErai9xNEgwV0dJMFZyNWdUYW9n?=
 =?utf-8?B?TnpBa0FjRVBESXZYNk9UNjg5dTlTNmhSMEZvRVRiQXV0Uyt4bWVtK2kwUms2?=
 =?utf-8?B?VDdHTXNUbmtrWVIxeE9sZitpc1JKbTJiR2FtTU5WZWdEUzI1OS8ycmZ3dTZ2?=
 =?utf-8?B?THNLWVB3Rm44dUJ2cmZiQktPLzJFb0dJcjRqaSsxRUI4d0ltSjlVdHJhS0dC?=
 =?utf-8?B?enVkVkF5dUluKytCUlkyK1k3KzVlWWNwU204bzZyMG9WRE41RFc5R2FFaTlt?=
 =?utf-8?B?c044WVlCYnR5a0V4RjQ2OXNIL1lacHpiNDNFeE9UdGFwRmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB1981.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(10070799003)(4022899009)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1lxR2pkNEwwOWYwcXNYb0UwUC9NaGcxVXA3TDNnOG1nUUtMUndoSi9MNm5l?=
 =?utf-8?B?aE8wTnpYMGxqTXhjeVRmMWJWazdYK3hEQW43dCszeTcvV0wwM29UenZ4SVBD?=
 =?utf-8?B?RmZSU0t3aHhORHJ2K2lQajZ3QytIc2oxWWowUDZMU0xTL29mWnRHbFYyN0h2?=
 =?utf-8?B?Q1I4b3hINnVjM3hjOVNLQmRvK0N6ays0TEYxbmtCUlRXMU05OEhHanU1U013?=
 =?utf-8?B?a0xZcHZORE93V0MyUGU3RzJKTW1sMlU3c24yaWRMem9iMUoyS3VCUXNTNkRF?=
 =?utf-8?B?SUplaldIKzVqczlIRkNTMG5NYlczL3J0YWhBcTg2bXFncW9Gb0ozUlFqeDQx?=
 =?utf-8?B?VENJLzlTTVkxaWNKTEFld3Btemg2elk2YlU4RllmMzRQQThXNldzUk1ScnFs?=
 =?utf-8?B?S3lCb1BlY01tOWE4OVV1YlF0bVd0RHdJL05ldVFob3JWV0U3OEdrUk0wRHcv?=
 =?utf-8?B?ejJEVytYeHU4bTJQYlN6SXB1b3crb3ovS2ZrWERLa3RQMkY4WGpvSjM3cGxY?=
 =?utf-8?B?NDRHZzNkYjZWdHR4SFF4eDlRN05jUEViQWJ3Q2pocnJiVWRKdy9HUkgyNzEw?=
 =?utf-8?B?YjNIQ1g5VFlQeGdjUXoyK25oMUJmZlFhZGcxcHQrWlloWjQ0c3VvRFVuSEx2?=
 =?utf-8?B?TTkzYXZoVUd3SDB5bWtSa1ZYdUJtc0ZTOFJ0UHlmdHgzdG50T21SMXVUYkxS?=
 =?utf-8?B?dzk5V1E1aHR5d1ZJODZkcWZBVUdYVlB4eTBBWU1xemR4dHA1aGJkeFpIUWtC?=
 =?utf-8?B?ZDJaOUJtZUk2TlNocXhjVGdubU1HQktvRHZaekkzUSs2V0JRRVpPMFN1YWJV?=
 =?utf-8?B?KzhXMVRrdkppbkZKU3Nvcld1dWhTSWJhMXloV2dMZlNPT2FQME5zY0dWNitm?=
 =?utf-8?B?ajJHTWJlRmdoUnFUZnNNWW9Nd01YdFFKTlJBWWU5SnBFV2FQRlJtMVgwZGRG?=
 =?utf-8?B?K2M3NmtWUHArbUpvZmJ1Qk5RY20rUjRIZFpVRVF5SDdnTWVtMFJIQ1pYZHRo?=
 =?utf-8?B?ZWI1bW5RMzNWbC9nMzZQYXZtZ2RMU1YySXpKVkxqNi9JUi9JWjl5c3dsM1ZZ?=
 =?utf-8?B?RTNMK1lMVnpvbWNNYm1meXF6R2l6ZzVJY3J6WkcxZzd3bUl2dWlHQkllV0kw?=
 =?utf-8?B?eHU0dXBtdkFtSE9EelFSYm9KV01TTVNYNmVjNkZOUUZmWlVOQ3B2WkRQSXVx?=
 =?utf-8?B?cXJiYUdPTU1TQzZxMHZCS2tCOXAzR1psSWxvNTFPZFAzK2pUc2s4Qm4rdGts?=
 =?utf-8?B?ZjZBc0s2Q0NMbndFOEVRV29GWEhkY2NjVnZ4Tml4ZzM1YTA1N0Y3aGJUcExG?=
 =?utf-8?B?UDEvMjUxWm5FRzIvTDMxS2Y0V2FJUi9KSzRiZ2s4d3FtYmtRb3NCclFPL2E0?=
 =?utf-8?B?WmU1My91aElvTXBuYjNzcXZHYitqdEpTQ2YzMXRxQmh5S3AwTmVMeTRPc3Rq?=
 =?utf-8?B?cE1ROHlmaS9jYWVsclV4NVI5ZFMzVHNNWjRJSXg4UGo4b3JiVEtTNmJIZDNj?=
 =?utf-8?B?cHZ6UU1pZXZUSUpldWVlYUdUbjJGMXZpRWd2UlJDdTk3cXBzUmo5VXd0RkFv?=
 =?utf-8?B?QlVYdkZmamV5ZmFxM1ZzWldJczZScUhCRldMMlBYam5PMUxXQjRVbGNKNlUw?=
 =?utf-8?B?NmZnNG9xL0FZeTFuVXBhN29MY1FGWUs1NG1qM0VoVjNDNzZJNmdnOHlrc1Zl?=
 =?utf-8?B?VjF1RWJjM3VrQWRPK2pmd1E3cHp4b2VhOU5TOXYrWkNrU0w0SkxKQ0RZSW1Q?=
 =?utf-8?B?NkNrSkNaTTRNaUJDS1ByRXdEWWxzaWFYUDF4bXdwOUhzcnhjbWRBOGtlNTM0?=
 =?utf-8?B?aXdMMDB5Y3d5YnBZT0FzOFJRZTk3VEduZDZNWTFmRXdKSWdxeDhmZ0dtL0hk?=
 =?utf-8?B?TTBmSEpsWGROdWh3Y3J3dzFRRkJlNTJubHZKbnpYQ2hHMGlDeGdBSWhCcEND?=
 =?utf-8?B?OHB3VWFiUERkOW5JWFRuSHBnQWVncUdOT0FZVnlZdlZkbVdTdG5WekpYaEw5?=
 =?utf-8?B?S1dyUFJQWVB2TC9qRFpHS1NqU2tINmtNMVN6STJ3OGttS3lRcjFOdmR0aFlR?=
 =?utf-8?B?NmJ2TDV1WHFvdHQrclJUbG5UOFZ6d1MrRXl6YTV4N2pIdUh6OERwd05RVW5O?=
 =?utf-8?B?cnZyNENLdEtRdk5ySjJGaWFXNmtnVDlkOVhENnVaWTFCR0t1SXlmSE5zclFQ?=
 =?utf-8?Q?26vkjLDL45V55Z5f0cHuTnaIo6gP+d6oxBtP57N7kM9k?=
X-OriginatorOrg: occurence.xyz
X-MS-Exchange-CrossTenant-Network-Message-Id: 9204b789-1113-454c-2600-08ddbebe7b32
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB1981.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 07:59:07.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35361529-4bc2-4565-902b-42d41e88413e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXJEJTTv6ZWyQwWZlHyVJmgqrMZfHEL0Z0Zl1VZxj/zRCdCLcYHa4giyd8mjjlTQ2xHnAwpmYdYuZTSr1lJKG27EI4+XwKp7KWhEGwZuQXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1382
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	FILL_THIS_FORM,FROM_SUSPICIOUS_NTLD,FROM_SUSPICIOUS_NTLD_FP,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MIME_HTML_ONLY,SPF_HELO_PASS,
	SPF_PASS,T_FILL_THIS_FORM_LONG autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 ARC_SIGNED Message has a ARC signature
	*  0.0 ARC_VALID Message has a valid ARC signature
	*  0.1 MIME_HTML_ONLY BODY: Message only has text/html MIME parts
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.6 HTML_MIME_NO_HTML_TAG HTML-only message, but there is no HTML tag
	*  2.0 FROM_SUSPICIOUS_NTLD_FP From abused NTLD
	*  0.5 FROM_SUSPICIOUS_NTLD From abused NTLD
	*  0.0 FILL_THIS_FORM Fill in a form with personal information
	*  0.0 T_FILL_THIS_FORM_LONG Fill in a form with personal information
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--===============8602527088095563106==
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJz
ZXQ9dXRmLTgiPkhpLDxicj48YnI+SnVzdCBmb2xsb3dpbmcgdXAgdG8gc2VlIGlmIHlvdSBtaWdo
dCBiZSBpbnRlcmVzdGVkIGluIGxlYXJuaW5nIG1vcmUgYWJvdXQgdGhlIG9wdC1pbiBjb250YWN0
IGRhdGEgYXZhaWxhYmxlIGZvciB0aGUgTElCUkFNT05UIC0gQWdyaWN1bHR1cmUgRm9yZXN0cnkg
MjAyNS48YnI+PGJyPklmIHNvLCBJ4oCZZCBiZSBoYXBweSB0byBwcm92aWRlIG1vcmUgZGV0YWls
cyBhYm91dCB0aGUgdHlwZXMgYW5kIFF1YW50aXR5IG9mIENvbnRhY3RzIGF2YWlsYWJsZSwgYWxv
bmcgd2l0aCBQcmljaW5nIEluZm9ybWF0aW9uLjxicj48YnI+RWFjaCBjb250YWN0IHJlY29yZCBp
bmNsdWRlczpCdXNpbmVzcyBOYW1lLCBDb250YWN0IE5hbWUsIEpvYiBUaXRsZSwgRW1haWwgQWRk
cmVzcywgUGhvbmUgTnVtYmVyLCBXZWIgQWRkcmVzcywgTWFpbGluZyBBZGRyZXNzL1BoeXNpY2Fs
IEFkZHJlc3MsIENvdW50cnksIENpdHksIFN0YXRlICZhbXA7IFppcCBDb2RlLjxicj48YnI+Tk9U
RTogQWxsIGRhdGEgaXMgZnVsbHkgb3B0LWluIGFuZCBjb21wbGlhbnQgd2l0aCBQcml2YWN5IFJl
Z3VsYXRpb25zLjxicj48YnI+UGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSdkIGxpa2UgbW9yZSBp
bmZvcm1hdGlvbiBvciBoYXZlIGFueSBzcGVjaWZpYyByZXF1aXJlbWVudHMuPGJyPjxicj5CZXN0
IHJlZ2FyZHMsPGJyPkNoYXJsb3R0ZSBEYW5pZWw8YnI+TWFya2V0aW5nIE1hbmFnZXI8YnI+PGJy
PlVuc3Vic2NyaWJlIHwgUmVjb25maXJt

--===============8602527088095563106==--

