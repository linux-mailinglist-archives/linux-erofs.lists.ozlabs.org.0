Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961D900948
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 17:37:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1717774652;
	bh=HDhvO5bYGBhBuZX0wWVjWzM0MXq1wQKWMu6+eCFTp1U=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UqM/Q9byFuztlxNb0fH+BEu2bq41Q59Fq7GEuo2q4x+4baMrLTCJyIn48Q2V6grxl
	 vwkRwYXJ4/2W7+DiztPnW5j6hWUzwVOfKQKuqq34YFI3EGfPT/wpYRLs3QU4GjmTP0
	 z56H5tSHy5j/ODU8gglfckALAdMrrE+Y4RVDOhzA5GgdFqTrt2biZay1DSjbgUHctm
	 MNCDJ8ZrRz6a+7Ymr3YppZuLyw20UWI4QOdrJPLqL8tIUN9AVMMmJS4A3MeMO57q4b
	 Zg4nuIihNykgf2KE5PAjbo6Qn9kr7K3Ym3v7KPlun7hTm+PPCoyk1zJ1NEClMtofCG
	 1SxDzDRc136lg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vwlgw0lPKz3cMQ
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2024 01:37:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=PWvSytpo;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=DsfqpoKk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=john.g.garry@oracle.com; receiver=lists.ozlabs.org)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vwlgp5vNxz30V7
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jun 2024 01:37:25 +1000 (AEST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CudrD029379;
	Fri, 7 Jun 2024 14:40:32 GMT
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbuswsjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DKjrI005462;
	Fri, 7 Jun 2024 14:40:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmhy918-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwUY9s9nLgE4XfWqBSDopfWOj842IdyO+Vc9fFfEQnNcN8IkQjzdQl0z3jokNOyPVbkTkvJQX22DtsO/SkLum59PojYkjkGYkkGv0I2H7KOzoxI6C5j4cJz3tU44KHFRRI0ezaukSCagluYVkv2gBSycWEx+/Iiyh+tauCbxELmkweqiMC/43iHn4F6tRTco1OPmYqm4qryddpPhyY10eGXS2z/wUQxuaRNqQSuNnq6tu4l+vgVniAyEKFYnViwjz39QwiQmKUty9rIuj3w0wFweer74gPem15TeQu5mPN0UMxUbNJIBpcSRKunt5yrWXe/b6Re6POuZfzoGAWZNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDhvO5bYGBhBuZX0wWVjWzM0MXq1wQKWMu6+eCFTp1U=;
 b=RO0WP64gruWtBo1tCezWSQE0G7bVWMSg812soc6lVm6c0n+FWsFJLXQuTwiHJRLpSuI8cfg9mhsLc5AwZjt1+0g5QzBIpPDD/l7LpqlJicpTzRrKUnnXdyfsRRYak2GSHHQ0Ydhan4qzxv5/dbU4bM5iB4wNyJck+GftVTe/SyWfdnsp5yt3fugmUaXcKLlGbuD68oe+HW12gjcwqhmvPXLqpzUt8A1CLksuotUlV6E4L6UrwRLQ8ewYMB4S3o/GmA/vCtf9BDwjhJu5PNJLas4Ps+OWa9AjMdbVbO1/XlK9uLiB8wyjKI5N7ymoxLAgdHOf/vq7a70UTOP3IEWJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:28 +0000
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Subject: [PATCH v4 14/22] xfs: Only free full extents for forcealign
Date: Fri,  7 Jun 2024 14:39:11 +0000
Message-Id: <20240607143919.2622319-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 975d064d-931b-485d-14d5-08dc86ffc675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?+h9v+R1PIPHfLy0O3kDO9J9Xma2pwrKnVTTms8mBdpV2tCntx7woXUQiecXp?=
 =?us-ascii?Q?Mzq9wWPojMusc0k+r0xEnTeCoVtiQeFuArhAa1BTT67TiFB6zdrDvnjP8KqQ?=
 =?us-ascii?Q?Xz0V/G5brEoH9PKxAjoVT2DGqlu2C7TE+HZ4VzuCNi6kZuvcKGTdD5G+Jd+B?=
 =?us-ascii?Q?m4U4663YsGVHpPHnmxlYWK+SpVB2ZN1T//hNTC2QuQP6SIrgOtz7HjDIsoK4?=
 =?us-ascii?Q?/cPVZimb3AeL1AjVT1ws/nxsZN0AX3Jz9uZaqTW42lADktsilqOQ8chxvsl2?=
 =?us-ascii?Q?PcPjmvo+TFFvZELDBgTl2zKTpu8YGcFTO6cNlQuDPdg0cs8mja+Aa62M0pTw?=
 =?us-ascii?Q?x0leYohQF4kprS9eEzH/i/Scoz43+p9ghE9/qu6uPru+GCrxKUBhxU1IPAH4?=
 =?us-ascii?Q?6FioXWWa5iu02dwyyGDP7WMWE3y/BzK6zdClqvJNbmenpo6bdbvKCOXAcfJM?=
 =?us-ascii?Q?Oo1PHq+laa4v3jLpadHVTHzDW9b5k4lYuLIlwKib+eq0ZSDFqlBS4HH0XQFG?=
 =?us-ascii?Q?xqBPdgM6GOI0oH954BERuEZMFm0Z7c+of7v2L3cWPjqZu1W7WcKRNOSK8Uwj?=
 =?us-ascii?Q?GfLqB1PPOBeSoCe7iv3mom/kItOTm+apfqVadYuaNhZNS+Biu51j17fdUxNQ?=
 =?us-ascii?Q?5TlJ+O1m/2BKf04E72Bcg7BvRhg6+ehMYKtKkY72ltv9vFWWIId2+GL8G0bI?=
 =?us-ascii?Q?QsaHj82vGRn2DCX0PfRZcVJQofQowy2s1d9z4/W6q9qi7pe7pPq8kiHpOsdJ?=
 =?us-ascii?Q?Fam+DHQIW6l0eAPegj5oBifpmPLyW+pyAA4j2IFkEqSWJ2/Da0/4eJ71UrkH?=
 =?us-ascii?Q?wHX48RSwlHR8zlP+Kpxxnn9UskERop2cUsgdMorNhcD23S2OgcekVBxeEj4x?=
 =?us-ascii?Q?wyL357rPLqInWTwC83L/xQI9kNQ1isoTeH2gTrscxxxNikRD/wQ+08hIOYvo?=
 =?us-ascii?Q?mvxwyHnAfgaU9jnEkg1jWKr62uoiR7+LPf0X1kGAkf8Razr1rOxg2LV1OmEW?=
 =?us-ascii?Q?t9kKRU4xdk0uZxBVDAfoH5kMKGW5x0q0eul0RoFh8oQ6dR9GlPJXqTSViRcm?=
 =?us-ascii?Q?Dc3Sh2EKmBa+D8vv505/88YdGGeNIOiMHTgwbQUsJJTje69g4boXxZ6/d6ld?=
 =?us-ascii?Q?emNaVtytgpwaPe3UP2bvkFa2/gG7HV+hlGX1m5iVyncVBRAUqqeoT9vGVyhx?=
 =?us-ascii?Q?Vdr6bw4XhNs3UWhSXE3B7IhBpdbqbPb45VugDQsulqJEQAkTagMblpsyTzK7?=
 =?us-ascii?Q?OICEV0H5Kot4jAABHFKDWTx+Iv8po6TbRADlh+19IzqLt6KaJ+6raFXEzQAr?=
 =?us-ascii?Q?TmQ=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?Opd0pN9Es/xqvE7lNAicoLprlQT1RjV7QOG2TF8AHt7tlToR8VEXE4f69Xhj?=
 =?us-ascii?Q?qmIK/Zbn3QMFFT/Nd8gQthjLQgg8cf8sF9WbW7fow9E/+elup1Yv7XGq7Znr?=
 =?us-ascii?Q?URJ2wSH7RsZYM6qqdQd8ZgF21Le1bCdWrOY+Q9Jv1IKTpjsvDSHTJZ9CVeqF?=
 =?us-ascii?Q?tEJJpuswCx4ywffYXx7t5jAMQwRgVp17RSu0j5njV4p1cAncpYHZjnvBC6Pw?=
 =?us-ascii?Q?DLEHHNAojoL4y3f6VG55L5Xff7zYxaIyrpIN5GrVYYk3AQBydPeJBHQuxufI?=
 =?us-ascii?Q?n52GcBG4o28AyKUbwJ3LrdD3li5N50tiutrjw2VD3ZtxcRvJTOhNOlvSATl0?=
 =?us-ascii?Q?0AVb+0Z2IfuAq5V1pRhz8TkSGD/PIr1s1q7CMWi3WDtqu1GEAmEVvT+8xKTF?=
 =?us-ascii?Q?WUCssKsPU4EgM3lBrGFImx5I8PZ5bPfj/uHeTwwUAVhiL6aD0ES0BfidRdRW?=
 =?us-ascii?Q?/0FqofwnTLB0EDYdZc4TJMPqSAjTXHocEdPkJTi3NHusGRZLRxGTFIGsrGG+?=
 =?us-ascii?Q?fZj6yqFDAeD+XAjODtnh0Ayi4v0Me4H6zkyZT8vGUJlqog+v1O7qENPNKyFO?=
 =?us-ascii?Q?OBEXpo/H9Xw1b/Bgyj5fZorgUneFw1ChY1Tq5n0qKtUPMWbUvhLOqT9xnjIY?=
 =?us-ascii?Q?+0k4MrXhMveAlWooI1RHpQV4+eWPpwolDlOF2ht+ykxT/tJtaNBTr0bqnQ86?=
 =?us-ascii?Q?DAcm9R4tnu7U0U2s40beKnJKU1Zd110xkiq6F74eQx1/15D7ZnY5pbkgK4Fs?=
 =?us-ascii?Q?ndDxDWFNRD79Fg2mDZ+pIoIr4hAAzol4fHmQW7Y+7bVU7DESCtSVgRfpBuoz?=
 =?us-ascii?Q?tqYhQV2egjJ6D0GNSodxnMVsXS9vSCTGZnykP6yOJ7uoKk9CTDz2o9vN/fQ9?=
 =?us-ascii?Q?au0gJH7RbRA17n/9+imhEiHbEAbqiraGvHz1pUgK19DY2exEeuGLRINf1kgg?=
 =?us-ascii?Q?GepWE7WI0Y4EM+s1ZMUuwpRxFR1JYIwDvJfVJl3nmE9fSKOEnxmFJrdgdsgp?=
 =?us-ascii?Q?82YWqOhrcCd1dwTUnQPjgPzBbBxT+B9S30n0VXyiyb/5NN2Vg3PIXRiWvxtf?=
 =?us-ascii?Q?d349sancn0E29YokH0a2gCgujpMPmpmSmaWjo4PqZk5vBr5KqTK3c18C8YLq?=
 =?us-ascii?Q?e/BZzt9fJUhANnNIEuLMubU2zT1OCq3daYLeAkHDTcr+VFDPSKG7oW3xJnB1?=
 =?us-ascii?Q?ezBHxbwysJQz9zYmCSjL89cf9HgSI6yGoUeuTsnqjZth4qX9pXZabqzqN+mb?=
 =?us-ascii?Q?M1YD8rJdLDvo6TiQClUc1YevEXxD7e9dadMPoSgAfU7HkuQ/M1sLOP6Kbjv5?=
 =?us-ascii?Q?b74Y2BNH6mJpsh4igAXs9BJo+ENNUxMqZTavDJuoEp6GIDFvJj4XO6NSjSP0?=
 =?us-ascii?Q?FQcmgnWAiOJdS3MJqkm6Z4wscsiqlyV1tUyrcCkbnZMSHnFxOTwgADpa7ZLQ?=
 =?us-ascii?Q?2eAt/BYD1QsgmWFsGRWJs741+wLfaPgeiHn2+GM66q889xrUjXhhE7xGF2Us?=
 =?us-ascii?Q?j4U0KJtMFimf861XnqzbquGLJsjxw0Pj9vh1g4hFdfy/aQXEX0N3mUQ8n4JP?=
 =?us-ascii?Q?L/CZKcPhqyeEljXrnn2en0+Mae3NTZcMz0hlKcn67lMzHGhoqdTSS83PQ7AI?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	WdEfVrOsUT8em92Hj2MRnYlGiaiQlvjkrpUqp7k6tx7fTZbAdlG/z9e5yFB9GPYrn4mVi48pJ9mFzYFyZjhbLjkUZtlZ4tzmkcg/vAwwGuPzX1a/T6EJg08UVWbvyFmaoiZOPSj1wDdGzABF1IisdpyiZyedJJmF56MKq1qtRlmfvk5hni++Aq+TxlqKQgkMwR/4EjEoxOMLNPRnFPm0PBh0dhcDIwjv/IVylSYVASTANvD4MwVP/UM4qmlDHw/m5ZtBi+WF/ekgtueAPSi8DoylpdH9yzBEAvEvifq3yGn51DRSS4aOhGdQr3rtIUPugdD0ebDP3JXA6/WtsKwWpbmn+OxKEM1IcsKq/sHyGKtYewxbPXlrVfZ63+O6tag276CW24l+5cfjT/bCEIJgR9UyhQoaYn8sqVHpj9KzxduHaqUihIf5tYzZkUcOoIAjNYs1+brXxABaZMfI4Ojs0jqRioeSWa0/sP/uT3beHKqOiQ3AffINJO8/K5nNKjT9buIj2DeLHkb3jAe8jbRPd6tub4hZ4K01pJ2MjpM2sD19QvnJf6pqtjlpezHkqH6B2KExlSFWojkVFQ/3Nmo1mGyoNojjq+1ZQNmOn/2V2R8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d064d-931b-485d-14d5-08dc86ffc675
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:28.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdgeuDqKeP79TCfC1/kvQHsPWfggR1tHdx7xCTQnC+qFRV4uETTUqIGf15/eNSb+1eSKaOsNRm9jMQeLTF1adQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: ALv6ujPmDKC6aG8PRq86AJAmZDae60tg
X-Proofpoint-GUID: ALv6ujPmDKC6aG8PRq86AJAmZDae60tg
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
From: John Garry via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: John Garry <john.g.garry@oracle.com>
Cc: gfs2@lists.linux.dev, catherine.hoang@oracle.com, agruenba@redhat.com, martin.petersen@oracle.com, ritesh.list@gmail.com, miklos@szeredi.hu, John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, mcgrof@kernel.org, mikulas@artax.karlin.mff.cuni.cz, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Like we already do for rtvol, only free full extents for forcealign in
xfs_free_file_space().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 56b80a7c0992..ee767a4fd63a 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -842,8 +842,11 @@ xfs_free_file_space(
 	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
-	/* We can only free complete realtime extents. */
-	if (xfs_inode_has_bigrtalloc(ip)) {
+	/* Free only complete extents. */
+	if (xfs_inode_has_forcealign(ip)) {
+		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
+		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
+	} else if (xfs_inode_has_bigrtalloc(ip)) {
 		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
 		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
 	}
-- 
2.31.1

