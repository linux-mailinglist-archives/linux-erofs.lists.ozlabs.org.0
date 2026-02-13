Return-Path: <linux-erofs+bounces-2312-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PfP8Gtt6jmmJCgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2312-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Feb 2026 02:14:03 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5382B13233C
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Feb 2026 02:14:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBvM56hNbz2yL8;
	Fri, 13 Feb 2026 12:13:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770945233;
	cv=pass; b=IjvNKdWs3nJeMsHOXuDNkBpcu1inTh734q/JrGyaszf7Tjn+CmmjQJNKrw7Jyyk3bxkIRV+4tB3XbYPawje3PBp7oAduBXn6VKCb2dBI/9RW+OvIXgguY+P0XSGbTK0kKb5R6fDJrN14zE08ocPZGo73vCGOImkaz6DKhYli/xguJpkDVs94y76N55m0rLusSgmAJDMgGVvGDvwo9f+xQz1khqQrmymeFvX4HJcrKgB0N7sOXHLpODjqrYrP2gh6N+7ximiW8Uh87Vy9W+ydcPOZ36oRJyJn2/NVUa55b1nD3qZekWhM/Hvdoyw5vVCjr+lvkdr2SOl6unuhqdjOkw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770945233; c=relaxed/relaxed;
	bh=A9F2CY3EufucHiOPNJsCj/TU6pFJi0GCjeAXRCUgymY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RPDVwjyYjp178wr4UNHb+vRoiXwDF58QWlRTTRYyps7luDkb8nFTBAIbQkqzB7hihWq/CaYtZcs+n5Q2dSgfAnHR/Tgk2Xoexa0Cq2CZVmTw4HpG6pYXoGQQKGiuW85CFqgWeTGVHFVg0V0CgGCyK8vzkrakrlTAPSuode9xcjVUa8VkFKzUH9JUbw+TIZu1LMDhjC2kugqkNRf1SNwzzGqCG3704oGGX2t3w/WDBd0lMvXnIPYrfyL/GE55vFgsU8tm03t0Nk+f6FpdTBDR7f/GRWsX+3C0pQs0Ch2MiDp7uQ65h2xgS4ROvaWEydSYBeaaysjNV30NTOsXGs6VSg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ADMWm/Z+; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ADMWm/Z+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBvM35PcYz2xlx
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Feb 2026 12:13:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ5jy4ovImQcCEeYubd/q3ZjdNKoSOAAX2zDdK/O1hZpsxv9kP/8jQA0gkoLVBs+ArkaVarzBnNKsd0dgHPDXI6xdcoPmMeCbZQ/vCzRQAbK4W9XdeowYw9ktmIF5JlgknTqin/2xjNx14st5VcHusrOxpy43N6gXbyI1rahVFPflEjIzh8KgX4L1/XShBkbgFpqJR9DMp++QSBb2UlfoIHGUo7u+933KTvgtmK6C+kt9jIajg1SY/8b+DeNsfVF4kvgTNRr2e6TUjuhGlyaR6L+9MJBWIC5+3Z9hyGVqFbevPsODwJT8pUSYgITU7Zt3xg6JBGaIC7Ar7Hdhc0UiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9F2CY3EufucHiOPNJsCj/TU6pFJi0GCjeAXRCUgymY=;
 b=lECswGUyHoPAyG1+kpl8SH9//HMND6JtIiVnrqwoE4DX0dnf7WkUUxKIl62BeTOlMPgeegHkYwLbGUofWxZ5KNj4nKW2DcKB22/Z5zbFAQUu1PLumUJIlKnPNCGfIH5kc6StRZKFisYIVJJWPgTlNeOPciZFOlphOG2/Mxonkd4CSgXA8n8HvT35SYTOQ4iRxnJqvQNMIPBjQvIJPZM/Ok97ijkMNiOFiUAG9PRGocssxEQZvASkiOEBGzWbeHrzCcjGmPgybvM93vsroPOf8iN0LN42iqYSpfCnbFQsnONaMGlqnDzKKHVMc8Px3gvfTzVITOT4Hj1L/xP8dn/R7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9F2CY3EufucHiOPNJsCj/TU6pFJi0GCjeAXRCUgymY=;
 b=ADMWm/Z+ySEGh7vF4CMMhQLH8skDwC/9jAgnSNUJBqmH/mRKaZnA5gIAW5BQEPIa262fkv7ba3QS+wvyQeJlKFrMcTFGM8DvU7Ac/WcPqNRKR0+tG3gSb4QyijxKatFbDDhF7KJ+vHTMFCz4hIxTYeLLHUpYwgTQnOeWCHlIeOPp1q/dmggMP8xI9HKRfkiaqq95ELaOgnMjSZ/b8lIfuZFXMSkhnKeBch9IjMTrO+iyvahKlaIPj+soalJF37K4AjjZsY8vuycR1R+nhJCGKn46puKe9malCHyUUXzdLJqAHASqsLXYoxoo8/8l8fMsz1qpdTR8FEgO9WSOg2n7Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 01:13:22 +0000
Received: from CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f]) by CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 01:13:16 +0000
Date: Thu, 12 Feb 2026 17:13:14 -0800
From: Jonathan Calmels <jcalmels@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <xiang@kernel.org>, Jonathan Calmels <jcalmels@nvidia.com>
Subject: [PATCH v3] erofs-utils: lib: relax erofs_write_device_table() device
 table check
Message-ID: <20260213011309.206550-1-jcalmels@nvidia.com>
X-Mailer: git-send-email 2.53.0
References: <20260212001302.72193-2-jcalmels@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212001302.72193-2-jcalmels@nvidia.com>
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To CH2PR12MB4969.namprd12.prod.outlook.com
 (2603:10b6:610:68::8)
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
X-MS-TrafficTypeDiagnostic: CH2PR12MB4969:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 058b3135-daa0-4574-dc98-08de6a9d10c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmdxL3NIVTVqejFDQ0JQTHBUZEhIbUlLNHVlZHA5TDhpWk9EdjBhQi9uK0Rv?=
 =?utf-8?B?Slg0eDVxTDIwUmYxRk9mK1FXbnp2TDZ4cXhQM092VE1LUTM1Uk1BK0lNOXBY?=
 =?utf-8?B?aUROOVoxckEra01uYkpyZ1ZTT3FOa1dPSVFMYUtta2dDaU40YW5vY2E4c1hM?=
 =?utf-8?B?MHJHWklhSEYyV2xIdGZ6N2tQVFJNZmVUWHN4ZDBWcGZaUUYxZjBnTmhDLzla?=
 =?utf-8?B?dEtaQ0c2aUxYbUFCOHo1b2h4SXV1UWVIUlVSRjNQNjdiTTJ2MjlFYmJyZDQv?=
 =?utf-8?B?d1JULzc0dUM5UWprZHBZazJKWGlndSs2V3RkNTQzUG5Dd3dLSGFWWHZaQ0Vy?=
 =?utf-8?B?eFpkcGtNOWh5aE5PWUdObXFsdnZtRElORm5CczZhQ1BodTNCYjV2MnFPb3E3?=
 =?utf-8?B?ZXFYY2JRc1BLNkIyd1loRlVNcHlmSVh2UUlYWndOSXZFRDJZNGZNNGpyTHQw?=
 =?utf-8?B?MHRrMXU4RnV5US9OcmUydDNyVWNhcXVLVXFNcXBIZndmUnZxRk1tT2xBVHRM?=
 =?utf-8?B?VGJvOC9nd3JreTNvRHBiRVl3THQwYlBQa2NPalF0TEs2U25vOGtLcmxRVlk3?=
 =?utf-8?B?WUViQkxrbWRuM0lTWlpFaVhoWURaV2JJOGwwOHo1QzQyZUtWQzdHVU1sSXhu?=
 =?utf-8?B?UGtGVEY3N0Q0cUlEM1FNdmg4N0xqZ3FZY0huanRnY1F6NVlNQ0tqUFJzUHZI?=
 =?utf-8?B?dGJXN1Q3ZlpzTCtER2F4N01XUzJ5OHdjL0Z0b1JkM01iNlJacGMrMzk2amNR?=
 =?utf-8?B?T0dKTG1PaFhEK3VwVUVNem9wdHVjM2JSU3h6UG0zT1llWjlCUFM0OUxpUE92?=
 =?utf-8?B?R1A1dE42aHVzN0FRUW85RS9Xdi9yRXJ4dFRVV1UxMEVzaWFkdk9yQ2NhY0d3?=
 =?utf-8?B?ZzB4aVROMkJWZGhwaUplN2JHOXg2NlczNHFOelV1MDdGdWNXUFo0aWptRVZx?=
 =?utf-8?B?c3FCeGtTaHIvaHIwanBGKzh4bVo3Um8yaitoeFhicUV4WWg3YmtyV3AwQkFZ?=
 =?utf-8?B?K3o2dDZxQStrQmlJR2JFWVoxZW5WbGJ2YktpRUg1YU56T2RkdnorM1BPejhB?=
 =?utf-8?B?WVZMZGpxUStORU1vY212elVJSk9DUEVqMmZ4cXZnVjU4S3BNekpCTWpobnZJ?=
 =?utf-8?B?N3VzQkQ0TUErMEt0Y25rdVJONmxkU3ROT2JIREJ3aHRTSkJmZndSVUNyQkp3?=
 =?utf-8?B?WVBGQStYQjI5Zk9ENmJVckN2aFZwTU1icE8yZW9yblNOME5sY1dWaFBVZitO?=
 =?utf-8?B?QVFSQlN6N1Uwc00vNU9wMjFCN3R0VzIvNEl4ZnRtRTNpbHE3QXhPb0xiOHBi?=
 =?utf-8?B?alNxT0JGOVFQNERzZGRkR2k0R0pQZEFPZmZqeXhmSTN0V3JUdDgrMG5RSHVT?=
 =?utf-8?B?ei9qbDBLRCtKQStCeExxcW5XZ3pPUDlxL29YdWJGUjBxQmRDSlBDMWZUbkJz?=
 =?utf-8?B?Ryt5bHhTUzI1SkI0dm1VSEhBYUIvZUVUaldFRHY2dGh4Uk9YZXZvaEVlc29W?=
 =?utf-8?B?V1Iya2o1OTB2L0tRNG5DYzdKZFFnYVJEWXFsRUtiYXU3eEJjUmxFOGdlLzlh?=
 =?utf-8?B?Z2VIekJJcnBCU3I0OHJoS1VqTEVJMENXbUlLUStON2JuQVdLdEFzOUxlT1lk?=
 =?utf-8?B?Q0lrK0pNR045QnZEcFpMUXFhcGJWZWRBOXQ5aVpJTEdhbXJ0ZnZvbWZ4NWpp?=
 =?utf-8?B?MloxRFdwZm95MStESEZxNWRhSVA1Ymxxc2lFSjRETXhENXQ0QTRZK3c1UUxl?=
 =?utf-8?B?VldvUGxNdlZ3cHNqcS9XeVVvemdJSEhPZFVveWplcVBZZkgyUm90UFpPb1hR?=
 =?utf-8?B?S2pCUUVtREU3Qll2RDdRaC9RVzFKVnF5VmtTODRvaWh6aVlMZU9LWlFhQmVT?=
 =?utf-8?B?dmliMy9lUGp1UDMxZk0zeGJ6WVM4ZnVjM2lXV2hjQUhVc01WdU9EMDRCK1FG?=
 =?utf-8?B?SEJzbE90T2lrZlJ5MTFGUUpia0Y2eGc1dXVZSkNXK3lZTW9MN0kxTVRvS0wy?=
 =?utf-8?B?ZUN2THoyL2FkcWd3MGNHQWU2SWRHNnRuQlcwQ0RuYnNTb0VnM25CQXNkVlBz?=
 =?utf-8?B?U0VGcVhIeHNLOXJoWVQwMlpqVjVIdWs5SEEzZmY0RnkxQjdjSjJxN25pby9q?=
 =?utf-8?Q?dkSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4969.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVVHaUNTSmplZXJNVWpzZFVjUjNobC96MEU4WFB2ZHQ4Z1lGWFdHSEpwWTVp?=
 =?utf-8?B?TWNrT28zQytVZTRBVitXbHdjTUovVjFYeFdIc2JPT3owUFYyK1NGZkFNMDY0?=
 =?utf-8?B?ZzdRYlk4QUpwNkpYcUNaaG9sR0RRcnV4bzBIN05jZHVRZEFZTjU4V3UrODVl?=
 =?utf-8?B?ZkpMTlRBKzFLYmRTUWxoM3dFWElwUEhnTFN1N1Z3TWRDcXJ0a1BpZEs0cWJY?=
 =?utf-8?B?dkd6Z1hxUStZOUVibDhCS1VIOGh4MU5uTWxxVS9EVkFpQVIvemRCUlp3MHJ4?=
 =?utf-8?B?bHVxUHY1MjZkZURUd1d3VDhPYXAybHpKNTlmTGNhVVphTVIvZjh4UHBJWHc5?=
 =?utf-8?B?M2tHMlNMcXpQWG1BWHA2aXJEaXJVbXJnREV6M2Z3Slp1YUZMcHJvZWRRQTAz?=
 =?utf-8?B?cnJYelllSnRGZEpyOUM2SExjTmhiNk8wR2pvOENUNXYyYW1ydVpUMkQzV2ZM?=
 =?utf-8?B?V0NwQm9FS2FQSXVDUlVZYVk4bkdxYlFlQlBRZnVpdUJncEFaT1Z5eThkRmFR?=
 =?utf-8?B?Z3duS216UFQxdC8vNEFabVpHR2gyZWNLeDZaejd2T1JhUUhudWNXQWxTQ1V0?=
 =?utf-8?B?cSt3WThybkN4dTg1ZEhCU0N2RW9rNThMR055S2huMGl4QkFWTWNuNUZVbXdK?=
 =?utf-8?B?N1B2TnVVMTNBVlVRZHowdHF0TGFXSDY3ZGJiQ3BOSm5PYnpnaG1HblBWMmt1?=
 =?utf-8?B?UmQyT2tXWW14M3l5YzBaVm1JVXpXMkIvS05ncklMcXY4d0JZUmk2RWEzcEtT?=
 =?utf-8?B?d1lpTjJpZ3p6dERaUFJKblRjbkgvSm5ZMGhDb3RtS0RhUE5IeEJ5NDlScnkr?=
 =?utf-8?B?OTlwU1VwbWQwVGtaN2J2VTgxYVM0aWRObFJRZWtyZXpGNm9NYUNLYUJoVElH?=
 =?utf-8?B?Tm5oOFRwOTNQV0liN1BwS2pUd2hCOE1iWjVuNTBHVFhsdWMxanJ0azBSeTNl?=
 =?utf-8?B?MWRlNEk4WlpJNy8ySUpaditsOHA1c1U2NldlUU0rN3Y0bG9vWGJPVHpqK1kz?=
 =?utf-8?B?cGIzSXk5bm10MmlpMWRvVjdXdjIvUzFxeFlQNTkzMXBLQXpGaXdBUmhDNDYw?=
 =?utf-8?B?eE9RQjkvbUVDTCtYTVRsTHVYSWlhajk4TVFtSU9uZ3pHRDFHTDVrV0laQ05o?=
 =?utf-8?B?eU9SbHlITGhnRjBkbWJjTkJva0paSHI3VU05OGUwQmhLQ2RWNWNuYlJlWTUz?=
 =?utf-8?B?NkM3ejZQN245MnNLUU5UUjU2MC9kMlc4Q2dNTGhhOTNHU2lPVHkxRjZkaDh2?=
 =?utf-8?B?WlE3dDM1S25Takc0ZDRVVDZTMTg0Vms1WDF2ZGRDVVFFVXlOKzJLSHVoc1lj?=
 =?utf-8?B?ZU9NRXBIRDMzcVdOaTBCQVgvTjkzN1dXU1lNSllUdnBZcWJ5RmlWejkxQTlt?=
 =?utf-8?B?YzQ4TlVycGNVVmxzeUEzM3l1aVF0bVBvcHJNaFFXUHJKbXVYOXFjcFdYV1J1?=
 =?utf-8?B?VXpuMmZySWREU281SzJ6OGdiWEtkOGRoOWYrc1J3MHhDa0gwU1dJSlVtRGxw?=
 =?utf-8?B?TWwybUwrbFZJVTdNeEdjSGw3cjZEN3pMRU1VVjdCVGN2cWpuTnpjZ1dLRXhI?=
 =?utf-8?B?RjRUcE5ORE5uUDdyRzVzT0t2QjE3cXp4eWVJYzVPRlNWZjVGUUxoVzRMZGM1?=
 =?utf-8?B?M1NOckttZ2lNdytiRzBDdlRqNmFuOTN2Mkl0eU1mU1loYTVjcGYyVnhIZVpH?=
 =?utf-8?B?Ry9MTkdCbmpva0dQeVBOVzk3L1BOaXo2M1l3NkgyV1JpN0NmbzlmeHVzczVs?=
 =?utf-8?B?ejJOdXgrYWdxaGttWGtEWnB5VXVYYnYwWjhlN0diM1FYWlp3MGN2d0Q1ZkRT?=
 =?utf-8?B?WGFKdFJrL1diNXNrNVB1R0dLbmV3c0NRM0Uwckc2UHROaml2d2FZQjh2TWMr?=
 =?utf-8?B?ZXk4YXNSZzUzV05zeHVOcGtzZFIxR3VpNm5zQXRNQlpkb25RcE9pbk9qMytW?=
 =?utf-8?B?bk52WjI5Sm1RS05WR2Zia1ZDeHU1dVUrVmZvYUhlM0FPSVBmR0ZNNmNWOGVK?=
 =?utf-8?B?SWtFTUFMbE9UZ0xtTXVlN0FIN3psZ0tuNGl6TFl2RlhjMkFpOCtSQ3JHSkNn?=
 =?utf-8?B?N3pkcm5qbmNZRzcrUGErOVN5ZHZXK0p6M0hiN2lTM01qZFhsMkgya2FPelQ5?=
 =?utf-8?B?ODhjaVFXY2FYcTFSUEwwVEt1THo0TVZNSVhjZ01zeUJwaWFuRTlyN0pSeFJ0?=
 =?utf-8?B?T2ZZUDVsUWd0YnhEUDkxRVV3NS8xcVpmc3BFNW9hZjZiN0FWU2RZY2dMdGFs?=
 =?utf-8?B?bFlTK245cm91RFpIcjlXaitjMjE5Y2w5bG9CRk5sMEpHWVFYRDQxYUZVY3RY?=
 =?utf-8?B?SElCdXdXNk04MjhLS1JMa1Urbnd1c0EwV0hYYWdkRUtwZ1kyZUI0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058b3135-daa0-4574-dc98-08de6a9d10c4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 01:13:16.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z19HK8xL3nQUAvKvYPxTlG7fIXKA+2rPSNBODsyx72McMkTDW6G/dqOzvfPTITLa0PfTBAhtOSv0Z2MMeoGfpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jcalmels@nvidia.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2312-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Queue-Id: 5382B13233C
X-Rspamd-Action: no action

Avoid returning an error in erofs_write_device_table()
if a new device slot table hasn't been allocated.
Rationale is to allow erofs_importer_flush_all() to succeed when
dealing with images with pre-existing device slots.

This effectively allows the following:

mkfs.erofs -Enoinline_data a.erofs a/
mkfs.erofs -Enoinline_data b.erofs b/
mkfs.erofs merged.erofs a.erofs b.erofs
mkfs.erofs --incremental=data merged.erofs c/

Signed-off-by: Jonathan Calmels <jcalmels@nvidia.com>
---
 lib/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/super.c b/lib/super.c
index a203f96..4a0bb3c 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -391,8 +391,11 @@ int erofs_write_device_table(struct erofs_sb_info *sbi)
 
 	if (!sbi->extra_devices)
 		goto out;
-	if (!bh)
+	if (!bh) {
+		if (erofs_sb_has_device_table(sbi))
+			return 0;
 		return -EINVAL;
+	}
 
 	pos = erofs_btell(bh, false);
 	if (pos == EROFS_NULL_ADDR) {
-- 
2.53.0


