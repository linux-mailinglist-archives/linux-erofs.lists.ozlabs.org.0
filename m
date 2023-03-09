Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E26B28AC
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 16:22:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXXxC4YMbz3ch6
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 02:22:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=dt9SLlnM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::70a; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=dt9SLlnM;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::70a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXXwy63j5z3bW0
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 02:22:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGMR7RLSdhpm01jsTykg8Q2EMWFnkZfTYGLqO9nWRf5MLDLr3WwGdVkxUnUMJ25oT7CBxrYSUM4vNxtPnr6QIzbO7gRHI51vaEY6FYsrxduJv3usxPIV5YREYUU8NIrFTPxm0mGZdn2Xc3nxrZygtspIZYB/BcVHuA6spmoaMJxngeZI2hWJXnna8ETNYkpPRPYoOdr5zqQuwwoYSFAB+0T0urKdVoZ7Cn8BxeKZI+eLlT7HkeUHjt0hlRUq/BiZk2jjysSZJDt4+UbS4TSfhRxJoGhfus5kEzJffFmbGTi47i4zwmbqszfVjzy7p6lne74b9lRfclZ9rhm7IVdcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WZ/gZ8tExJodLukafBwYfS2IWoyWL8CyYD/KVgopyM=;
 b=RH0idH2FO9oM6mybVQjw3U7J0b3d1+sCwe8+n4jzkhnxFT3oqa1LgckNpq23NPc4wdQEHOnlUY6cU5TgS8yPD2HzXU6j2650Wp0biwuBaorYYm1r8pibVrOCYp/uoDo9hUZvPDOzzSSwdDHSO3p1gcMgiJOMNas+7YEYpOkI/D7gQdM4fHLIh+6tqXnzHOas2FGZPXVVnS4U+CR0QasWK50SKNmrsMhic2pWLcYpTO7b3qPpNK1Of2Sx3DmeKunjeJlTMS+thUozSBQpcfBsCAwJedTTInYGSbbo8xjWvBjzlBJTYayLgZinhfsKim7h6nV9gmmHrpOiXDzbeMm+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WZ/gZ8tExJodLukafBwYfS2IWoyWL8CyYD/KVgopyM=;
 b=dt9SLlnM6Vpy5N5sVaKbrOVTgHD+ceAEgRbGod+sxc2ygO0DxlvPNG2BsuVMqo3XaskcyYFnkj2W8y0Hjen7OkojyGIg8QajWSdKRgX9tfFA1u0UK9RZaKO56HJisR5g7b1nCayLvLvNxZ5D/C570lPmAzozXCVuTHCCGK3IYf/540E/jErQp7FIkzjb2HgGnVzMRSnX0RQklMCaQzJDhvpIQlXbVya/K/Oowa1yfxGrQ+tc4F7wdiVDZS/hQOmVJ9NDwNLSDSFLrK02ZgLv3VnLFDFeIc2vNyvHAYUBlMzm+h2dEdqNygW9HoOYHDQgbztSC7aGl2Jd9zzfPjVN2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4073.apcprd06.prod.outlook.com (2603:1096:4:f5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Thu, 9 Mar 2023 15:22:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:22:08 +0000
From: Yangtao Li <frank.li@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	rpeterso@redhat.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v3 2/6] erofs: convert to use i_blockmask()
Date: Thu,  9 Mar 2023 23:21:23 +0800
Message-Id: <20230309152127.41427-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309152127.41427-1-frank.li@vivo.com>
References: <20230309152127.41427-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: d461e413-0f51-4f1d-d76d-08db20b20c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	E0GSNzAaXPcAcRhkThhiuonbAkvDbLW6KQzMnphafn2WlZNyifcGrYNJ5CLxRycHYcGCAitOJdWkvBu5RpNcp/hxdd8+7rOkPk5TOH84OFo90L4u+fFoz2uNrI6G/nXvHeAsONCYWfXzRDdiRHWWnlfmSFPOPqr8M9OA/Ifp+AYEX6QNxbfXSSUwqN7oBufMCCXhFFnzSxNt/dk6E6MxktDNNae7lQBbsBvMxhYCSafvoui5v3Cy2ykWR9RnuQHiZUIHo+/+hA6R/3Wi50PJZWDaKEeidMzfimsvGg0cihtete2tQGtMSfo3zm6tUXW/5WZUeBSMvxKeUdcluoXNqh1fY2dRn3bi7zr6crBtgVd+GKJV5AaWBMN8UHPJ4MIFzjRFhDez0333sUMioK+J7WEvO9zgjkd7cKA6wzB5+0gDmnmp5DGgH5eInrptD/QfgmWO6By/dhHsPsWAc51hs7p1zv0L4HiruGPMpsmgCLTOL1KCUOLk7hOJFH6YfA5uExgeI7f72KI/KwjoIrZ04zpm+DCzUJasrdn+SbGes/Z5FDjgPscLGOtQubsp1ANle3JB05n6flipJuZhHcFug+/jAw8RWvCKC/tpbJok2JiiGGilsweajTvv/oKnwH9Qk0kDvkHj5mZlQDDCoUBkJ3+5yLlmzd8133DdYy559natBwyIB51Fb82itgKQ1dEeFDlup3S1dC2Gq9xxPVcbZL32CfEvTBFkWvujX1kG0tU=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(316002)(36756003)(921005)(86362001)(38350700002)(38100700002)(1076003)(6506007)(26005)(107886003)(6512007)(83380400001)(6666004)(186003)(2616005)(8936002)(5660300002)(6486002)(478600001)(7416002)(52116002)(41300700001)(4744005)(66946007)(2906002)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?8yK9O2+P0NeBAmWglWmVMSrjQ0UvgthaZl4gA8Rta59Rps+AP4shb22ftqpc?=
 =?us-ascii?Q?UdkZhicPc+pLg+Oiv/CW4nd7HI/CtsxIbreZZv2KG8XTGF+sXHjTBC0Fnr7N?=
 =?us-ascii?Q?d7RAqp70Yovq88zt9ztINEvpucBpE+l3UPhSRIMrvIlBgMiXKKH6u0soyCGC?=
 =?us-ascii?Q?blxt+slfWlPjzVVSq+Jevg1vn6VGB/v+HcPwXZT555yTwDJkeldwKMa3wYwH?=
 =?us-ascii?Q?zM7MoTSn/iSI07K66NpmFlmkdMlj0vrT++OifJp71BEgBifY3zvD8b7OiTXK?=
 =?us-ascii?Q?rAmLstFNspMA7NiljWXx+hR1ezn0DUEVo34hcZkZ4ZnWw1C7WrCPtjzDMI6Z?=
 =?us-ascii?Q?bUsAtPmdzZhkNVbgiR840bZX+JmMi5jGuFc0O/zBYfNROvM5KBt/gC/lCD4w?=
 =?us-ascii?Q?DAAlRowkarFZWJaG2WrcKHFxyGn7jsRZuN74jLNn6lUNFBAduIwzeMF74QfG?=
 =?us-ascii?Q?BlHEsJ06pvrk52dSdiDNc8dykeAlY+D99HlQ1235Z7JCNyyf516ihBHopMjQ?=
 =?us-ascii?Q?ohh3aoMPbZWm6P6mK5Rg63DAIf5MzrDCdQvu81+rOMPOZaOesljZW8f+R5hY?=
 =?us-ascii?Q?IR7rUiVtP1VIYt8IZbmMdyUIyKPVi0e38LUf3rtjNaR/oBunEOwh6r2VJCYo?=
 =?us-ascii?Q?ZEXJJs3tbBl3b5EubU/RjmGbAKqSA2UybNfvdQ8Zrl06Gom+/vJoWNh4a4vz?=
 =?us-ascii?Q?eCwj+UP6wRA37H63qEeO3qZn4DVEeqSot4y8XNs9vpH3NrOXxpK6r0RCaMR6?=
 =?us-ascii?Q?2GEQUreeqyQg/1n1lrX6PnwgntIHiegZaEkZh+GZoPwAfuHkyCGlKIxpCbl+?=
 =?us-ascii?Q?hS+/IONU2CFC1Qx3nyJHa668fTf2PUUEPlLUTH3/JPdHowBV50DotF2tMxFZ?=
 =?us-ascii?Q?BpmigM76a0ANxnB9zelg9i/HMbIwClbA7TAX8WyMI2G8S2PEUHbOPLjzWEWv?=
 =?us-ascii?Q?JIkMxkN7ISy/XMCFnnvnFEPWG2nkYp5jo8NY0Jn/4Lii6U1ouWrINX98qVKP?=
 =?us-ascii?Q?qahibKPUA36uG8Sda8zI8YyqPCKuk4YUmRj2fJolaONMdX7bOin5PCzJgpWK?=
 =?us-ascii?Q?NO85zH7MqFKVuxno8E/N/UQGhRdQ0qum/jvhi8SzV0p8rTEkUWr08FCwP4tV?=
 =?us-ascii?Q?nmjyb/Hu6u+emQ54JOILNvOTQKvV3piWUKMPYhbHfWuryMKmMx/wpHtXzM/U?=
 =?us-ascii?Q?0L7fQCaZP40/x5E8fAEcniu1nNd657MU9r/MS1xPdZr5pNTgfYY4t4NhI1y3?=
 =?us-ascii?Q?o/6Sah34rSQE0TknMgm01Bk14JFtsaE0KdAAwsVOruQRigq8wL3XR/XgRqrJ?=
 =?us-ascii?Q?HUwfKCkqDpoodFeZKzyQ8YDtrkEMOOOhBMtVgp7qg+OXAnsItqgrCiv6kcGa?=
 =?us-ascii?Q?+K0kgwxreAjL24CzNh4ssiYLUfvVQSj9tKE6dgbTV45eXpGZfSOSeAruMrO0?=
 =?us-ascii?Q?9UNkpClNfJ++bEbmCMnrKeHvBiM1mtJlSCSp/7jw2nHQZxJgcrxMDvPdf4bS?=
 =?us-ascii?Q?k57PtMQDaXEYWrH86/9tp3mfPx8Kpt4bHpgZI8DhiZH69AJwE2c+9QCGDHBn?=
 =?us-ascii?Q?SoyWvhF7ktVMD8JPEHC8+DDMN/D4YiE8vStb7r+h?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d461e413-0f51-4f1d-d76d-08db20b20c3f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:22:08.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQpvvq5B7tilzUfzChSBYPrsS+VXR56S8jADb84bY9ha6sfWsC99ngdEXpgUYI0kUG3WSnesGUAPO0kYQ1244g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4073
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
Cc: Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org, cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use i_blockmask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-none
v2:
-convert to i_blockmask()
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 7e8baf56faa5..e9d1869cd4b3 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (bdev)
 			blksize_mask = bdev_logical_block_size(bdev) - 1;
 		else
-			blksize_mask = i_blocksize(inode) - 1;
+			blksize_mask = i_blockmask(inode);
 
 		if ((iocb->ki_pos | iov_iter_count(to) |
 		     iov_iter_alignment(to)) & blksize_mask)
-- 
2.25.1

