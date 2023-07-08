Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C600474BC60
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jul 2023 08:26:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=RfnDyjGw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QygJG5VqMz3bnm
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jul 2023 16:26:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=RfnDyjGw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:704b::72b; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::72b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QygJ62P9wz3039
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jul 2023 16:25:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWTetpgVFFU5Ra2Ha+YqwPAfGMXsgbJUdzTltWelxciyhITa/XJybqkGgFym5Ebg5f6tBH235CoSboESeIV7VEZqGUe62jxp32qTPywNpkABYRWPjThnKCI3803HrdzFHvH1/Olkz5wRRY9TYHx5cSzX6C5V6ONJowQTolRaG4reSUF1WiHU74K4Xq3wAGce74mZ8wHrv1E9sKL4RZ0lkAzpm1GByAF+DrGCFqPIkykQI0dIAsnYk9YmLf3VAEERJtliqUnuaZt6W2h/Yza7cO/an4CuznC33wyukDtbvn8O8DoXmzjDDT4hkYouIVvRbfkCojfLoNOSSgexydW5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5hyXC2cc1KjGWSui4/Lb6jxFgrEn2mlVSFkJ8lo3uw=;
 b=nEXs6ktm7YpUz+As5BCC8MOcwX/RMz6lW++1jyrQYuzKt5mhf7rDnNllvIfVs+Fk6u0NfKPbzg4ehVwUAlNpwYUWsDVl9MYuqGgtXRwLcPvqR0l/0ItZYba4XXPd9vJLYEV5zMzRfElJAHXagWbpjXoXe3fT2D71DaVOXbkMBAx6aJh7RgBCDqPwinToVZ9sdwT7bYLjJozGAfzK0XOkHmlrWtaulKvNe0Wdg+lAV7zR6Z8Dah4ei8CQqp5dl99p5Ia570K/bO9DbSW1+riEuKJWIYTqizwXfWy59iFzVteDTgMYanOQkGCBYIs2yyTIECA+FaTvjZ4J/Om5Y3sdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5hyXC2cc1KjGWSui4/Lb6jxFgrEn2mlVSFkJ8lo3uw=;
 b=RfnDyjGwPMk98Otlm+V/A6jvHPh5OZlpj0Bkq+RE1z3EsHX42n/XGBYXYFvksiG8h/7U8tkOJNKvqxHccMecbMOxd8y0KhlWf6Ye05xy9ltHrK+NhQ7cUZYyVrEQBzxmfnDmGxHzaGc04DFRTzK/G066N6yXZtgPxOEJ3wR19IedlpBD+p0AtQSXD3faiK5/UjuYjRCJgk2Qkui7YB8Vlaj5wVNCKt7KmbIYvE3KDRevL6UoleMsWn09xpQd/51AWRFpLYYAlR1ZCMSUiTmcWOgZdsuwtfhE1SWCTGweRULbCZbYDVkb66h05kV3v4j2bqCMTw8TCPirgZy/06yeTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by PSAPR06MB4503.apcprd06.prod.outlook.com (2603:1096:301:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 06:25:33 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::2b85:24ad:2492:c96c]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::2b85:24ad:2492:c96c%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 06:25:33 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: fix two loop issues when read page beyond EOF
Date: Sat,  8 Jul 2023 14:24:32 +0800
Message-Id: <20230708062432.67344-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|PSAPR06MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6bf441-165d-4a18-1938-08db7f7c2208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	52RwkpjHMX47KBzbp6ThDAmhC/roiw/LiVeyt23pBX3GIy9NMvzPhf86y3o2tueqjy/h5oJvDiGvdMeYEmnTlWxPk5Qh60NHHFyoA77EIW65UOxXqGE8wzc/nIUxJxmDF9LGen9CYqUchLzcbHh5gcjX4SxW+fv+9nBHpqwgFRKuLur4PQCXId4yp+ADC1L05VvUT5Y5TPkb7oAPOme7AhO1AXNsJ3T+8OjdkysDfXLWL9xRDmD+VOB8tLgRS2v0RMDiucZM/3izn/268qVMyvEQtTZbk4p/18mjWgI1T+EoIRExSOJ+ETf2PlqhWqMEpKvpS5zRH3XTL4Kit4Z9JP/hNlrxUqpt3dzKfVqle2YEJ0Aag8uOSoJH+3PWfOREJxY4YwtqTcdilMcy7IDLjRGkFnCvw80VznnVauIQg6+3SzSifUu6Q0CcYO8TbvAMf40MEDmIiwoFQyKyctbn0A9CsELjL4uBYkBSzjP41qUy0mSfyiPAMhJB8UvPW64Oq6y+R2pRaeswLv+MnMy+fiLOiGPlrjOd1Dq3Nq8qyd00F9lEZfiAjzc7XklA0iE9A8MD3ci0HsYL19zTb5B04ZfM+kmY1RM24sun+tT4tRf0iTsVseenGMfF6qHe7YIA
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(451199021)(41300700001)(5660300002)(6486002)(2906002)(316002)(8676002)(8936002)(4326008)(66476007)(66556008)(66946007)(36756003)(52116002)(6512007)(478600001)(107886003)(86362001)(186003)(38100700002)(2616005)(38350700002)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?eAGsGzH40NzUXhkzbB12d9DTJ5aI6I03ulawyNt90nMnr+96sc3cBgkxGX+8?=
 =?us-ascii?Q?XELQQjq6eGCG4l6eiTylwyt8tv/TKWOVEQ73rep4P1nKxKuBcHUCFOBtTzU+?=
 =?us-ascii?Q?DcNCcpKGERf1pVCKnaUVCkt3YdcX58PlUeu9/iLsgF19XCFJWgpKKLz9+Eo3?=
 =?us-ascii?Q?tgpd+I0nJ3REyIYMiC5PBHzM4ek4DzFXiiXFOBxK3fy0h/8JbfXkofRH6nRX?=
 =?us-ascii?Q?EyTS2/5DbvUWTKrZ0qSMVRFkFVK0ZKetIJ4+8qYdZ3wYEjKL34SNvBvpiltG?=
 =?us-ascii?Q?ZSf2VUR9benPDhlMkJZuCdYds/sbL1aewCjrSKtIDPzY0nHzhLi1iGdsIPTP?=
 =?us-ascii?Q?7un6vU6QG9JdtBYye1N8Jr5cl/2iAsjCERzY9aNuFnYsK9xgp6Mc5Y0W7dI0?=
 =?us-ascii?Q?SxlQrD10e9kedM5KuQJqTOnOHT3Bsf650NzYoo4qgqJfPHjSV/XK5ROmB2js?=
 =?us-ascii?Q?U1Z5PMAZdk2UXR2e9QQVSWT/eGpbS7X2vBFk3WE8Ur35OjwLvYbj3WH5WJyp?=
 =?us-ascii?Q?xBQQbId6GyBYgVBGoVmCbkFPQV5gEdX294SSgjrlEjCMpsCdJtPFyJhVO0Gg?=
 =?us-ascii?Q?sCldQKZf23S4YG0jZHA7JpC0bE4E3ERtiK693Pnsq2HUyeuoNRA5oXdSUdh7?=
 =?us-ascii?Q?AOxyvKs8LJ0p4syy2hxIHfAbEfAnrPi6vblDOFFFJdMRi/7MOAuBidprGail?=
 =?us-ascii?Q?v8NF1I6vMZOZZvu1FYxh0d3ei9HkQSGHkK8XILXHBDMSA1em3buR9HoZQm6X?=
 =?us-ascii?Q?3Pu6zrdJ6VIofGrMUP5cJu2BY1zubfVfKw2/jAvQNZlUuCN8Xe4aWKMpEYec?=
 =?us-ascii?Q?HW+eDDl3lhqlkN0bRqkOsCyomJ3u/mrtk900y2AjXbXc+tFMsC1rf/hyp47L?=
 =?us-ascii?Q?3O3fQc0Hh/SFj8pSqCEkfRV+lEHYmNduYJjBa9pG3C/eBlK9QTRixwQZPm/c?=
 =?us-ascii?Q?iMyy0GJwKxMo8saPctViroTGNt8oHMlV1rprWQKWTcYM6LfsZbnPpse8xE86?=
 =?us-ascii?Q?XYtfyM79IpVc05qIEAmIntOdvI+ypCtRy4lAagtIDoLjwgxhqrqlhBjFmrXp?=
 =?us-ascii?Q?aUsxtUCzm9haZ3n+DSkP6VgwdTi/PMvs3sMZO/USvTpgqNF9Xo1Gql/NQBhR?=
 =?us-ascii?Q?JMVHxjsfucj+mZTH7f4NDBlMB++Ekg/fM+ueby0VEV+cEiucajGmVzunPjPm?=
 =?us-ascii?Q?91mNbHtZwrlSv42bP057W/nRHDU1XLhk5SV25Dute/AL9PBmn1BVc6POX5yf?=
 =?us-ascii?Q?4zEf/d1ScHwrlcgKefUTNwuhztMQ3GvcB3uajO7FJbngngUEgutS02ZxUc17?=
 =?us-ascii?Q?N9/DebyU+jQ1OsU0cO55EZ5uKnGLEQR3lUHqJXUX6KEK5IpkPnbAcNtyPATX?=
 =?us-ascii?Q?w7QcjqOQ7WTBy1GCmX2GJl/VENcHPIaBplqwegtALi+4KNoH2GdS1sM0eqNn?=
 =?us-ascii?Q?IECapZTOaB1ACLmq5OEEOaXRaiXsqsKYSakfq+oddGqhdJQEKJh/bzvOaCHr?=
 =?us-ascii?Q?PEyTIuD/1zjb9QN6QJHMKk30AuLBW81LexoNw1Cek9lOmcx/y703J2zfaodh?=
 =?us-ascii?Q?medgDs3dws3YKQWNEpTEKTUELzApaS+jG65aKdAx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6bf441-165d-4a18-1938-08db7f7c2208
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 06:25:32.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRb6DHBizRuKwg6+3Jz56Mbm8V/y6awwPVC/UT7WzdUXJQZWjiz9SBdr7JuxFeF1ymeoRxRC3lG/Eo7Iy1yQ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4503
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
Cc: Chunhai Guo <guochunhai@vivo.com>, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When z_erofs_read_folio() reads a page with an offset far beyond EOF, two
issues may occur:
- z_erofs_pcluster_readmore() may take a long time to loop when the offset
  is big enough, which is unnecessary.
    - For example, it will loop 4691368 times and take about 27 seconds
      with following case.
        - offset = 19217289215
        - inode_size = 1442672
- z_erofs_do_read_page() may loop infinitely due to the inappropriate
  truncation in the below statement. Since the offset is 64 bits and
min_t() truncates the result to 32 bits. The solution is to replace
unsigned int with another 64-bit type, such as erofs_off_t.
    cur = end - min_t(unsigned int, offset + end - map->m_la, end);
    - For example:
        - offset = 0x400160000
        - end = 0x370
        - map->m_la = 0x160370
        - offset + end - map->m_la = 0x400000000
        - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
    - Expected result:
        - cur = 0
    - Actual result:
        - cur = 0x370

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/zdata.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5f1890e309c6..6abbd4510076 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -972,7 +972,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
 	bool tight = true, exclusive;
-	unsigned int cur, end, spiltted;
+	erofs_off_t cur, end;
+	unsigned int spiltted;
 	int err = 0;
 
 	/* register locked file pages as online pages in pack */
@@ -1035,7 +1036,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	 */
 	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
 
-	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
+	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
 		goto next_part;
@@ -1841,7 +1842,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 	}
 
 	cur = map->m_la + map->m_llen - 1;
-	while (cur >= end) {
+	while ((cur >= end) && (cur < i_size_read(inode))) {
 		pgoff_t index = cur >> PAGE_SHIFT;
 		struct page *page;
 
@@ -1876,6 +1877,12 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
+	/* when trying to read beyond EOF, return zero page directly */
+	if (f.headoffset >= i_size_read(inode)) {
+		zero_user_segment(page, 0, PAGE_SIZE);
+		return 0;
+	}
+
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_do_read_page(&f, page);
 	z_erofs_pcluster_readmore(&f, NULL, false);
-- 
2.25.1

