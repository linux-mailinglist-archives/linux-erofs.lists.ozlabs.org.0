Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D91822CE2
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 13:22:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704284535;
	bh=GZMQ6eKMIpVEgDOY8ufi3mPKvcs+wEB8yUY4nrbFC2M=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ZCAMPAGaSpRCoW8BoONmFAGn/Nzu8Pyu5rNKf2AL0P3vO6fEJiFq1sQqoOg+/OxBx
	 Sk/bS5zTkRuFC++TEXuS8RjTEh1zq8Yc3olhy2LukrKWutmAoGDF0zuYedwmGI1Cg1
	 LKLhy34ONgohsiJdN1GMoIcN6+wtlDPrB2Ug+ByvZB25D5cG6KL31SyMRu6wUPk+jc
	 9y0Ybt+7ir8o0iN85846mhAxdrVuBkijEaCn1jLcmhhbcAhDqwfpe8EqDVZy4w17Gl
	 CPHFhJ7l2QieIdH5+uLtI6pmaILOwpqYDOiJPDW97NmxPqiJ5FFP0mKoKhsEAulQcI
	 44txnVGcjlusQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4pkb2TKGz3cZ2
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 23:22:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=DHVWjSHu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::721; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20721.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::721])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4pkW5BKwz30Yb
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 23:22:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXHapBt3Cmt+5WXNDibNszjBhvx9b64d/YjL/dll8sje3Oy5afVqsJbey1zfDJdlpPKNhr+RCt7+W9HBoPpPXYFBgK1qE0bwLSyfnTHcG66ctfM1jdLBPsmRfHvAWd1p9m2HwlYXJye6+0hqTJg2iemckhmb+oT2UiV7oGTH/GlFu5dqqdiaG0EjdzEJ+MM7/CldkAdTv/jjkcjIVB7Dos8TdjWGNvW2cgguzjdVg7xEFYpG4hq+MSdtqWnAm0z/P4Ii7VEkv9PMpjMGJOFSqXA7z6fysdCfjgZsTckOPRDzD7fLMYIFmCqLjYhoHvLjRMEgDs5O+5jEauK7ai77HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZMQ6eKMIpVEgDOY8ufi3mPKvcs+wEB8yUY4nrbFC2M=;
 b=dTlZ7WconRq/Vulw3Fw6g5+OF/7K70aufOTLY0qfuKP5m1mdax0lPTfCalaKDMj9uSFpZNElWd9GHB50Nl6BNpcQ775dfLowFndfhKsDIh6RAhFB6fooqgjc1MN8ju5eQtezdDTrWvyQA55W1Mr9G6iHw2XXZ38GfCKn7A1XJR/c2L9wnJq/E28V6MitYD+X+vjCFufb+x25vhAETOrRCpcn/GnlJjTcv6lBBwcaSAPV735uyehMyXeVD22tcwg8uBjz3GDTEYMS/GHbDNxbDt2CkUun676HS/k387cZ8qRL/odiGva1IFDTSMIJnWZcUB6MQbP8KNnwW9L5YGikuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by JH0PR06MB6343.apcprd06.prod.outlook.com (2603:1096:990:18::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 12:21:46 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 12:21:46 +0000
To: xiang@kernel.org
Subject: [PATCH v4] erofs: make erofs_err() and erofs_info() support NULL sb parameter
Date: Wed,  3 Jan 2024 05:32:02 -0700
Message-Id: <20240103123202.3054718-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|JH0PR06MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2cf9dd-efc4-4edf-24c8-08dc0c568d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	aBkw/M7De+3psvwP+ETP1HTvJLOE/juBg2oJ/3ZRKTuvaHEHQHIsHlNcjDinYFKxLulm673OHAg0XhmxtmlYopQ2ZBPdgckX0j8ggqvkviyM5u9acoMnzsv+cZPHiHOCsAUHFd2aJMmVolZXzDSDCGdycfa7wSyBS31Wu+f/qLCovjUXoUWxYlbUizPlFcPD/RcJMHUvGHO7nh7k7JSGll3uIlNDiqB5GPkgL0NsIpYnt6KyzQOJtft8z0TyKG+JLsWfchBu7ryng0CIAGanbH+x+jYZ2Ak+tgaM/xMuWqyLnh6xHo6KpfW4awqTyWBCsD2XJLA5N4jiSjlCxb7iyxJt10/q5XxShhe4A8RXhaMQEKhKTJwyVM1balHzv1h6sJ2bDyRqrZ9LRmQC8W52kJOq6T0Z+1sJgGz5mDVCq5Tip1mTUc4M6EyO+TLBYArRglT2U+rj5j7toLDnkWFo11cwv4AV9Ckw9x56Q4eSN5chas24UpJqHRxaeKrfkrGixKuaVXqK0mmL6YA6EwugyDVHsd6EZ5OqpxyPP0aF6iwm/4mNaH0aYAPNdvKKrrGFPykoG/AzxTbARpr/A/fSrjbVIGb3lEVXtzETvBOFUJOjPxSXySUeMtlY4C0ATBgZ
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(26005)(2616005)(83380400001)(107886003)(38100700002)(41300700001)(8936002)(316002)(8676002)(5660300002)(4326008)(2906002)(6666004)(6916009)(478600001)(6486002)(66946007)(52116002)(6506007)(66556008)(6512007)(66476007)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?se60WUXyTjlmZmO82pPXKFCxAbeVidKlGvjjCgIKsayXtRQ51OfRT/TR6Ctr?=
 =?us-ascii?Q?5yXnIo56McdWJcAjJbXA94VU10dMUIbAqEwcdKpt3AdVYuTEbRHgRqgPbF1f?=
 =?us-ascii?Q?pG6wiG1M/FwvH/dUwAhswAmLLMb4SJz+wnAIvA5eCNZZKZa0pSHBlVY1YtMa?=
 =?us-ascii?Q?UTOHDpRwr+P9qcgo4fLeFsf/Psc3AYxyE+Ba/a90rZQ2OSUOdB2WX+cwPryv?=
 =?us-ascii?Q?/C5ofJFPBd7g1wCYU4BgZuNQ8HgVJEcmuJ2mrh739kF25Hx3dWtjHPK9hjxf?=
 =?us-ascii?Q?iLEJs3pw7Hiz2hC2jskyCZwf9BV4gO/ugdu8wTK7V31NY8EMlsriOA4A4sGP?=
 =?us-ascii?Q?9TQpGin6SuEezuH4mgJ0Anx+ieYGD2jXy3KUA1fjU97I5DvCML+Hf8xm0AE1?=
 =?us-ascii?Q?CX2IblljzmGRsT9/NhJfzMtbzBBbDM1X5I8cOZ7dPxR24G9KwBcHYQ3prUTh?=
 =?us-ascii?Q?6KLxC5hQPDohn6FDdJuHFPi+I/MB40OdYGiKWZ0DvSXQP+LwR94h+inbBInU?=
 =?us-ascii?Q?RNHh/B1nBzl455Gm6ZK/QlR218Zw9thNbKzaw42zebpNx07EXBCn/B+k7XU/?=
 =?us-ascii?Q?GkHqEuEFymRcc/iqKqWYBvK9/7aKBGU3Mvu7WNQFZkwABPCbCw98G6R5Xz5H?=
 =?us-ascii?Q?XYrXUfXN+zoFuz/7qNTDxrFDuz1MfxqmrpK3IP+NfFSi/6+abWvqbgglzTaE?=
 =?us-ascii?Q?QwNQDYhejpNCGw9pqOo07wslpBb+lbG2rypgBVqqOLBLMMH9MJCVNwKWEahk?=
 =?us-ascii?Q?Vh9wApf8n5a31lN3g25reQaxnDG/2Xi6Sqj1yNwysAWl/O6lEC67R6EX78HE?=
 =?us-ascii?Q?WfQxFGrSItya8y4RvEXkCRGkjvLSLSY+3vp1s8NO0SnAFMetxVDlA7msIWql?=
 =?us-ascii?Q?oB6u6orly4M61nO4/7UZezVvhilUtRhS658kxfrX9jh9/dqPA67rJ+sLu1bJ?=
 =?us-ascii?Q?8Xu0/obzYh+bYd09Nlxl9qTrMQuvzWf1KQjO1KE4Xe+kZnAiAXlLITLz63XJ?=
 =?us-ascii?Q?f3ZcKWdfzLN3mN859M7+TkJakN3IsCJNEZbOYn6rcttANtiaIHoBrtnNt3Pt?=
 =?us-ascii?Q?xa7rdEByz8cIQ0QfqNyhmcIx/Mbkvtvr8yFEFPrDnjbO6W3PxoYLh4yFUNvY?=
 =?us-ascii?Q?VLO/dq5AmOrsOoinFYIdFf4k2WcDfDxyGJtEAUI+YBvg7QwG/AIOzMs9u9gl?=
 =?us-ascii?Q?wS6FmzqwVDGWPM2+1lkPVeBsuj4Y4yvn8C0vSk12Z+IuaQT5e8sVxVpSlw7p?=
 =?us-ascii?Q?IwRxjxZrq+a6G07HGzyAi4Uiy+0wG30Aj7eUPJ/jLZDC7I3ecINLjaFF6aCY?=
 =?us-ascii?Q?shCgvykwhxu3wO7o+rXm4n9ny5NXZVQQmMgy52Dquyfmbm7M46VVI7nsTJ/C?=
 =?us-ascii?Q?12dCPfN03hwiHtjZxPWG1VsX6JNP+Ug+tMEZIlBQqkq2I50O0Mb3umAxAM0o?=
 =?us-ascii?Q?mAzDTEgg0p2FBQsaWMimODouqILCm4O9WlxF4PyOnOM0Xb5cunUXA5zIIhi8?=
 =?us-ascii?Q?bJj6bpiJGHmIpczO+m+SpWCea/LGScaaui/iCVFF9xXsDZZk2mbdvBoKpidO?=
 =?us-ascii?Q?kQevU+g1DE0J8aXwwqatld670qIb4Gfo47DZoqO5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2cf9dd-efc4-4edf-24c8-08dc0c568d46
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 12:21:45.7817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9qWerfP/XixVQXr8ky1zfR2dkccPz79Buwu2AZe6sqUnaTxOd+pzN4GtiSouDI7WLGLNSsAFJRl0G8KTECHfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6343
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make erofs_err() and erofs_info() support NULL sb parameter for more
general usage.

Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
V3 -> V4: remove unnecessary '\n'
V2 -> V3: convert pr_err() to erofs_err() in erofs codebase
V1 -> V2: add erofs_info()
---
 fs/erofs/decompressor_deflate.c |  2 +-
 fs/erofs/super.c                | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index daf3c1bdeab8..4a64a9c91dd3 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -70,7 +70,7 @@ int __init z_erofs_deflate_init(void)
 	return 0;
 
 out_failed:
-	pr_err("failed to allocate zlib workspace\n");
+	erofs_err(NULL, "failed to allocate zlib workspace");
 	z_erofs_deflate_exit();
 	return -ENOMEM;
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..5f60f163bd56 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -27,7 +27,10 @@ void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	if (sb)
+		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	else
+		pr_err("%s: %pV", func, &vaf);
 	va_end(args);
 }
 
@@ -41,7 +44,10 @@ void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_info("(device %s): %pV", sb->s_id, &vaf);
+	if (sb)
+		pr_info("(device %s): %pV", sb->s_id, &vaf);
+	else
+		pr_info("%pV", &vaf);
 	va_end(args);
 }
 
-- 
2.25.1

