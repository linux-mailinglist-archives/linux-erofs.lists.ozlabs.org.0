Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A72D27AC
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 10:31:59 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqw1S5vTmzDqXP
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 20:31:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.53;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=h7NcKdzE; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310053.outbound.protection.outlook.com [40.107.131.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqw1N05YRzDqVx
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 20:31:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE7KAIcXeVWpMfpug5MBCisHfY5fODJrc0HRvaUfY/3UpfvunjIvog4jBaXLW4FyxeLMcfhrnJzhB01m6WSWZT3CBUfeFAovHc5g1QHNnLJgBhKo58AlDcSYLoPPQODeEY+j8dzTUNu1wMCk6rRSfgWQ3GR8yZ+fICAS9WONVVZQdclroIZcWSyQncq5715MC7dG5FJ28N9pnRPs5Q7/Tzled1+Ls4mO0PFVzGsZwbNAxoVZ1RKaHCLqJkMfYgMH0yYakJHBj7RPSeb6e+a77N8M1jmIifOulzRXL/21GDOOMxJaybrW8L2i9XD0BRslWPZc2L+tz/C3Hkutixem1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4brvwARNT4xJYBpqk2ev064RWFxQ40y4JxkQtp+AvY=;
 b=bLRv+ahaPYn9KH2WgBfKjRYIkLIoZqrAC1bhfG9hWmyuC92cKs+o7xQYG08cqHB64wMCqLmtwRydA9O3at7SNiv0fRIGWYBQQex26sdYV3ng/7qWx54ihkIHIWNGm0CUcKOVqSfyKYipujQPpf3WOqH2A8H6GWPgmDXHiSm79UERn6m7Z7fCco1StUyhxo7cGV566nYmiazjhTk7m0oz7fU/BcqXI5Y/r4HxLrQBlnL34xB7JQBGkePTJqsnPpfv1+twz/VCsgLDjhNZ1SPobkv9UuSkGnI07ey340JD0ZYvA2+wt4Ff7oadtBmpPMTw13BG130z80DyuUtOZLpIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4brvwARNT4xJYBpqk2ev064RWFxQ40y4JxkQtp+AvY=;
 b=h7NcKdzE7qhof+YT3IYux9QqzpD39CvVdoCRPawhzx2oxE5AcMKxnqAbOtFANFFlSBySgxdK+ZQpl/FPKZpL1/seNL1qWK02hVSzYyBvGWUqQe4bq356zytoNkOMd/sd7ymxntIUFjY5Goo7tgsiLNV8DLlhLzbBkVdHGGARqb8=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3576.apcprd02.prod.outlook.com (2603:1096:4:31::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Tue, 8 Dec 2020 09:31:46 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 09:31:46 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: fix wrong address in erofs_get_block
Date: Tue,  8 Dec 2020 17:31:33 +0800
Message-Id: <20201208093133.5865-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HK0PR01CA0060.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Tue, 8 Dec 2020 09:31:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58cda8f8-f3ca-4938-d052-08d89b5c1490
X-MS-TrafficTypeDiagnostic: SG2PR02MB3576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3576528025413AE205725C35C3CD0@SG2PR02MB3576.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2C9uW8YWZ21/akH4XtELfXoRxkabM7bkmoqmc6jP5jr60XgP3lCB6lptaidSBTDCcz96NWZeMiNswuLvjpp+FuPg6s3DrIuFnQoGuDKWb5L6rnG6ENDQKavAt57UNNBDAuJHcLaQE0mtCiQW7hOKWRNeyOMHn+JfdPTC7eh1WE6I/872p/oIBDbr5wsi7YW0NbQxPiEMzzA+2Dep2KWLTOXbtFUqNOzca7+QV/Vta8SkHNMHVSOH9nljxBPeKML3tzkYu+toH7ZPeePx5tIZwnd62lhUSid7h762fbY+ycwf6Ic/Y15TrRNbM5w2P+fXSqO3OoQi8XnsNHduLuBXvWQ3lDDtHx4OQZTIAWeyobGiQ7obLJkjl39H2APVzo4c4FYYr8fqeFEdxU7bQz4cmj2E8dZ+xuqf67doGXIFtlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(186003)(66556008)(66946007)(66476007)(6512007)(52116002)(69590400008)(2616005)(6486002)(36756003)(2906002)(8936002)(107886003)(6666004)(5660300002)(8676002)(4326008)(956004)(26005)(1076003)(16526019)(6506007)(86362001)(316002)(478600001)(83380400001)(6916009)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ttUbuWRh5TxLw1clQSf+mAdHFUTz7za7bl/WoSMTKteR0up81GcDVKjwfjnI?=
 =?us-ascii?Q?u74F5gXRN7UlJgVfYgSFbAwZOao8CVbSGvviGOcaICHR9EqLPIyehtV8nQFA?=
 =?us-ascii?Q?MmZx86JGLJk0uro65aVxhgge4OIC2KwIv8QecFe28o4UjIB5uT3T6q6CffDJ?=
 =?us-ascii?Q?8XgtKaWKJ4c4PmhsaqYPxZom/bH+3+mxr8c6TpAtLXjR0i86ReQt/NvsSCh+?=
 =?us-ascii?Q?VmjKN/idC0AYHIXgIhyzfvvJ1JufCm9jfnxcSHusxtFM89mCHlpRbikZUJH2?=
 =?us-ascii?Q?kbBZdwzYFsvv9CoyX8/j/kgATIjj0TItEss8bsqb+qD/9e12I/TL9NQuNzMx?=
 =?us-ascii?Q?7azi9vUEY6nJh4f0Zb7ja1o9E7gsQN1KtHsfR3CeBHbXRS8X/4r5nkU8JHh5?=
 =?us-ascii?Q?Vf7aVq/JFTZgRNpwk7wvcc3A9UHqSJlgfUF3RLr0AkcOeRH5OqqK23GU6HpP?=
 =?us-ascii?Q?RnE0EqJ0By8sJZ4S72khc3b8zRcacPFaHj6qs1U6F9e9DUVv6NFCnGYzBSpf?=
 =?us-ascii?Q?/4v/h6AMsylT3iDAEHlM60Yk6WP247ulZFNP4exlU9J/Iv9YKgR/K7q6hZY7?=
 =?us-ascii?Q?+aSZlWyZI8vMouSSLfs4xPWXw9LLA2svWvmdbdldEfiiBs2y3u3kev3wDrJj?=
 =?us-ascii?Q?3ppnC7WKjPlXWPNGqmNc1VxBFZa2K64zq7UYug1rx3tBJBpOjAgO8NeRPVqB?=
 =?us-ascii?Q?lKGb0uSk+w6ZxEuQ2EfHKPbCLqkJ3D3fWT3M53yrsQfcVwPQCtSDfBxMJ84b?=
 =?us-ascii?Q?FbltXunD1XuY+rhFJky8HpiKCEDw/QKWMQ18U4bIQcLaC4lRVe7cmrEyI+8H?=
 =?us-ascii?Q?DsoSEC11JcqhakAsRAygR3xbxtZV34DdR8QFA35MRJGsIcQSEutzQf9uNJUz?=
 =?us-ascii?Q?XWGbgbMtcCKAcSkvNwJjawSSAfDOV7jl3pNNQ7cSTw4m6WHyGOL92QtEek5+?=
 =?us-ascii?Q?mPG8vj5SOqFnUzw5eKhYo+tlhBOu5kMqJcJ4Wj5Li7/y/XJ0Q7MIZ5snMFvF?=
 =?us-ascii?Q?hdLK?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cda8f8-f3ca-4938-d052-08d89b5c1490
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 09:31:46.0884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Adkww45PHWsETLEoDvOsXpxtO/V/QaQFYjifvKNqAozcBf7X9RKkZD0oU+B4SsAqJ21fXUJZZGrCm/3WX/tOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3576
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

iblock indicates the number of i_blkbits-sized blocks rather than
sectors, fix it.

If the data has a disk mapping, map_bh should be used to read the
correct data from the device.

Fixes: 9da681e017a3 ("staging: erofs: support bmap")
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 347be146884c..aad3fb68d6c8 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -316,7 +316,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int create)
 {
 	struct erofs_map_blocks map = {
-		.m_la = iblock << 9,
+		.m_la = blknr_to_addr(iblock),
 	};
 	int err;
 
@@ -325,7 +325,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
 		return err;
 
 	if (map.m_flags & EROFS_MAP_MAPPED)
-		bh->b_blocknr = erofs_blknr(map.m_pa);
+		map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
 
 	return err;
 }
-- 
2.25.1

