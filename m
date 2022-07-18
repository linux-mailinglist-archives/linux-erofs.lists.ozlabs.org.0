Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071A57809D
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jul 2022 13:21:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LmffY392bz306r
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jul 2022 21:21:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=GHK8XAPw;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=KWUaD7tF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=GHK8XAPw;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=KWUaD7tF;
	dkim-atps=neutral
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LmffP1L9Rz2yT0
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jul 2022 21:20:53 +1000 (AEST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB44RZ019928;
	Mon, 18 Jul 2022 11:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=Al3R7w6qflMNSh6TdicQjp4e+QLtM+CgVviRUf6LtNw=;
 b=GHK8XAPw0pVQR0b7BbOrX/iXdid0tOy+rk6vGTtsrunztxYZJEvcd4yrryo+8qRY2qEj
 cuO5YebzlYem2V8nOBvldMPQi+V/np8A2rnmcfk+F8iKfZrqo2TRXloiGZ4MGjYvc3Zj
 jWGWi5HHIEbHahSH+T3iSdmasNEmEyj3r0pU4acHAHZlKc2NU7YMpaCaocpaC27EgEpR
 +aRZ9AO8CDpVms/CPPYqTsp8FtZV5lqSoal+VHGl3GuYFAEDnN8/SZJhejMV4z+RNLk0
 4bIkD6tMO2IEPqJM3jQp3VK3YV64l9jQOqMaEyOlRr6z+wNIWiFz0gb9bQMTyp2CJniU Gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtaxtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 11:20:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4wHt028116;
	Mon, 18 Jul 2022 11:20:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ma5t7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 11:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBQOTIn5RSORbVmSaWgxQSsHjvi4n4HTDCVhj99UMnIBP1l8P5ai/BfNaqVDVRQVF4JMa56pPimI1m6aPjS4Pz0TLg1N/wkHEADwRNfXcXTdlDr/9HUqWxGFP6rBazMGzUI6dYq1pw2+e2f6NGkLcxS+PnbNHnafT7eVvIWi/HPiXfpqiH5EkYbp79moL/26te6un3kF9dhs1amA4vT43nAgHqGS9Nc6U+Xkbf2XrllgRKsWORfeAGZIHC/5Ag2CQgZ/OFTQe36qtPNI/jCTE2wOREZcnFS7wYR2KOaeECvYj8Kcb1EAo77+8cVg6o/WGdq6SEHkoD43/Uk5hZ8SAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al3R7w6qflMNSh6TdicQjp4e+QLtM+CgVviRUf6LtNw=;
 b=BhYJnH2UaywmKluRvUeHWO8L+CTZ/m07uH2j9UVzIC49b68Hthq7rnBkU6KMsL8wACLKFKz3nw95QyX/X6EymTNb4LWZ6RaWhcLC5v+bFNtb7kvkc0VmxBMitOWK+jhjU4Tgay3Z1HQQvLW/esCzaK/lJzQy4rJe/PjXGdU+uZ1stJ4y6z0MkG6kuC9xkrjGk8ZaznfPfoxwPS9/NdnJlgzP2aeahf9YWDgVhG4ZpFWbAzYPcymyenCj1RSJ5XSqR/W/gQP16itf6HVwpviRoaTY8yUanrrcjvKzTa1rK5KT3bDrDGeIL86Wzx9G0yFBg86AJ8xmW37djTiIxNfhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al3R7w6qflMNSh6TdicQjp4e+QLtM+CgVviRUf6LtNw=;
 b=KWUaD7tF/GEg+6jBRsiW+0ShQn5tvQi+8WGM1xWOLHvw65diepP2+wg+9Ft+bne8kXSozJfcrKw0YRN4AVlHqC44cyRj8g5mklfuABy2umGuqdATTQfZ6fQWoi/UUg5pdjN+CGh4gIh8CM6v2RooH1QOxNMWkSxHVf/fdQew/+c=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3992.namprd10.prod.outlook.com
 (2603:10b6:610:9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 11:20:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:20:19 +0000
Date: Mon, 18 Jul 2022 14:20:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Gao Xiang <xiang@kernel.org>
Subject: [PATCH] erofs: clean up a loop
Message-ID: <YtVB6GBWHVSc6fbU@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0181.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eede3d02-786c-444c-a8c7-08da68af7f58
X-MS-TrafficTypeDiagnostic: CH2PR10MB3992:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	83XrbEaSsiKI6nlFhp1rD8vE1VlAMM2BDJEHP85am6Us1w99YmEWVbTLFzdAJt4P+MJKnQhWSc8mGADd6ZBNxmAU9BeQVPA/LEiGe0POBF0euO5hmgXuy39JJ97WanDLlb79PVbRThTUjG5f9CflWZ0Ghy9a/acJ9udOiH/SYJN5IfgqOZ4+T4TJzGcr/5faZDd+q9Tx5QcBEyH1Klxz5nYGW/plE5kBaa/oNi09LV9rzbYzKi8IysfvHUJOJiGSJqXJqr/njF47HS0wKwF0UUhTx4U2y0cIez7bEn4DNK9AjOW74wWAcxWlgDPoytFITz0bQc9qEw7GjXupGcBboD9kyFA5fRKqjGOl/GzE74ycIcL86pwIaKK9+mVEUxyJU6gUfUCillffV4C3vwx9O/4bLU5L0l6OrSS4YFXGYLvKB5EOfjoPq9E5BVMAzExPDT6iR7sF9/F4BZssxaPurAcpULnwuo3xh6EXEApbvLo7/qiQwMUu8ne4rWum+QO7Lw48lxMSLQP+yMLhX1zx7ml69505fawCeV9hujJRLrvxL4Kyyot2OUaGi4GlY6C1G2Sx18cX5x6Oh7/FXADuGEg1cZqTPNIImuVfZujEabO6FGoIkgFyGs8B8ze9JYFjJosHHxSX/zOseXyCPAvnA1iOSWMpjHJ9pX5Asz0w9xQqMT9vNo4JFXqr0DcCuFDoCiPFkMmdZq1WQp3NGLrXQ5iLL6GJjTbVCQSoIaVfLL0YfIwykpIvS+/LmYHjSCHdtspJ/uFR7Q9TgVTbsDkJc09aD7vsFDPBiExkmopJBadFKBP71dGEF9MegcJT00rw
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(66556008)(4326008)(6486002)(8676002)(186003)(6512007)(83380400001)(26005)(54906003)(6916009)(316002)(9686003)(6666004)(478600001)(66946007)(4744005)(33716001)(38100700002)(5660300002)(44832011)(8936002)(41300700001)(86362001)(66476007)(52116002)(2906002)(38350700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?q8HU9mTnsLIWIxFFfJ7IjRBHzK0w10Mw+miD8791bxeMdFb13M+aFviRdrr7?=
 =?us-ascii?Q?xsg00X0wtklbakS14RR7S3ycGK4Y7DsKo35GA5GWTH+2iThoUzHaxm6pCIiH?=
 =?us-ascii?Q?yAu37+J/F+V/rCbYUf8OX5FLx7RUHJ1RoxRZLv5o5REuJunw1Cvx/U3Dic9q?=
 =?us-ascii?Q?ztO0hM4gLyIHrE4QqnLO4jS2OhYs/nrnJxOIYKNI7AsQoPjQmDP6+SNMyX1d?=
 =?us-ascii?Q?CbmO7vxFc06wwEcAJuxERjwp0AKbgb8K6aBlLKdRtOiXJQqbCimxp5D/u+wR?=
 =?us-ascii?Q?qMJHLZ6HLZqgH86HrBP1tJnKxDvIlQDvOmC62KtO8CB0BTNcJYR66/hfKsgs?=
 =?us-ascii?Q?q3EBsk5rs4gMsQxlfsCI6IG4Vr+NDUtXzuunM9qN1PTiR79JPqreMp64PbCp?=
 =?us-ascii?Q?7FZlj7VaNd3xYi2q6vQN3mxzbxcES6L5IKrTzDkyT8Fp9p8nVyKnVne6YWfA?=
 =?us-ascii?Q?RD/zneWhO9+6WBqvO+P89gyGadlAvIh61ABN9o9UI1n/yK0hxCck9g/eAp6E?=
 =?us-ascii?Q?dBV0GCa+lrTX3UlV5sVdQuw6Ro8BOOVY4s7cZlHOdmOEg5q+/lW4VYvd7iMQ?=
 =?us-ascii?Q?m2jnAWl2oJKzsXGq5zYiTc0Z9pwW6S+gBKH0vY+tz4h2gkVohRwl41AeuOZ5?=
 =?us-ascii?Q?kcTVY0OqPli2RgqBUb/BbCFZ2W5N9ZzBHbfv4XPW51Yud3/cUMeB8R0IK7XI?=
 =?us-ascii?Q?oA4daNOgJiSKeqGcccGaNmqeZIcws5G98Up3k2SjwZMEXipbEExjRs4TJYdr?=
 =?us-ascii?Q?GZs9Ld2QUAWfvUOCWq77CFbWMJF9q24H1gg6uMFF/23itaNjnnXKeOJ3w0Hj?=
 =?us-ascii?Q?MYI2pkL0Mq94Z9CM+lk0MMcK9yfFgfxwa046yBLBAfo4pztCAmLw4uEv6NoK?=
 =?us-ascii?Q?NIz9RIf1tQHUbHrGZu7UqSD02zzC4KX2Fnwes0ubIYS7T2s8kWSQGrZZB4S6?=
 =?us-ascii?Q?aQbVzWMBwXxTL21xqcWOZhwo+CAHAw1UUOQB+DAvet4A4IUoll3pqETnoKGW?=
 =?us-ascii?Q?wRBC+iG/y5csNKTUH7zrqdL1W1UI3yPsaCN2AHYKpXsFqzomEe1EOo5GYqPX?=
 =?us-ascii?Q?itwXbrmRNq1uWKyf9JGe+/m30nnS78OQjcM5FlRNc7dORlGafYDElKHb57gj?=
 =?us-ascii?Q?hLaSaUDi91BwvWRO218OZNWmDWNZ7oRyh3k923bJJAG7IqClhM6Skru+lKxE?=
 =?us-ascii?Q?e/l3iIW0z3gN/MsHza3FaQxE8EoKlYKlnHogKtbG6/hrl9wpZH9OvmydUzzf?=
 =?us-ascii?Q?loYcJQtW4VBQTzeXyVk0UAkwJQizUXUbCW0cS8bZjF94JwBq9NlhzI8k5Pqd?=
 =?us-ascii?Q?+E1QuiaNjCpIDUDxBchZK6XeEwV/ZghQtnylle5/8Crqsebrd8LgwNvjUC28?=
 =?us-ascii?Q?GtITADdaTJTFGkIedBayxhytFnHhGrMle9WS0Knh+zXbHDAeUe/kSGKSKAhD?=
 =?us-ascii?Q?KmEBsbaMhfxU2/zcWZupIGi3eoldJZud6ekd97Jc7TBKabXceItAamoHHhIh?=
 =?us-ascii?Q?s1FsNyo/DPOYLRgfDsf67C/tv0dfxfV/nEVBfRR5nDUJ6IE0pOkMomUbxpg5?=
 =?us-ascii?Q?N5/RhUl5fNRt7KwQb0S2HIicoFvNAOrQF5hWI+AzQn4YCkzofbnpygb01iCt?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eede3d02-786c-444c-a8c7-08da68af7f58
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:20:19.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdQN9FJEBC8tlk78FkZMAqnOrEthUcmePHo9q347OKtsYRLOShy1DZWPPOa8lFyQgU7oFJXnpM93eKPWqqS1G4aIbS16R31konmwYQC5mNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180049
X-Proofpoint-GUID: Y_6OuKPhtHwHlnypCtCmI7OekCwVFTqs
X-Proofpoint-ORIG-GUID: Y_6OuKPhtHwHlnypCtCmI7OekCwVFTqs
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
Cc: kernel-janitors@vger.kernel.org, linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's easier to see what this loop is doing when the decrement is in
the normal place.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 601cfcb07c50..2691100eb231 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -419,8 +419,8 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 {
 	struct z_erofs_pcluster *const pcl = fe->pcl;
 
-	while (fe->icur > 0) {
-		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
+	while (fe->icur--) {
+		if (!cmpxchg(&pcl->compressed_bvecs[fe->icur].page,
 			     NULL, bvec->page)) {
 			pcl->compressed_bvecs[fe->icur] = *bvec;
 			return true;
-- 
2.35.1

