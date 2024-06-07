Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B01900882
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 17:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1717773499;
	bh=W2UebVop4icorFeB0cOpIPnw+i9Y+qIqXI6Qcjqu794=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Pxq0vo8i1PpbPn5MiSwxb51POL9qZ6upLMLasiGV43xfmcwQe0bCufDp4/s1HIoE4
	 0+azURgdga5VNMTWHqLDaYMNVNUIpjRwXy2/V4wwQjC63bIA03ZRlYcMo7XCTm+7vO
	 kTIo0kNYP2gwVGRaXDvqYXfFYTZKWL9JJMez3QGN9SJySnl3rXkHcyfIfBk7h1FfPX
	 ZcFychpYIleNxoT48RvzMaSViRPQpzcBaFWSYnLCBAjcKZO64FVmBqIiNJvP0GPLvi
	 MOaXq0j4XtdY0+K6IJ/Wp8QdQ7P3mZe6/MPqDUdVDFtQONPFeDtxm2z2Tq+y/6BSIQ
	 BCR4/LSjTz+xg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VwlFl4rDFz3cNB
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2024 01:18:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=de4TqHig;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hMCcxL0k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=john.g.garry@oracle.com; receiver=lists.ozlabs.org)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VwlFg1xkrz30Tk
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jun 2024 01:18:14 +1000 (AEST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuaS7015422;
	Fri, 7 Jun 2024 14:40:26 GMT
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjvwd3tfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DJjfJ025263;
	Fri, 7 Jun 2024 14:40:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtd3092-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SteNbgAT9vF3JJEt07XEPvn/pZYMTKYW5Ln/T5e3SKROtEhIOIZwPwQ4wvjR9odvfoEsYxg955dDP5WAB9q3dJafdODkfDlg9HLO5+CMR9fvV+NNbYhx7vH2Ze9ZM+HVNy7KisKPOprGoCJIKCdosHCYIXVwd0GPI9jRB9+RVvgOsszCq2FvTckZAYp/I6OFD7WDDhnVXrmg/ldLTwdShOes9nDnMIA2DEYiq6zz8ejKmlCAyTq8dUcXvsFFON3sC0gdDJWEDFThGhU3fBMaxhcNL2cZrizlITABjcg/C2SbCX5SIt0mVjsgYUms+Clxe8GjrVAEGDFc579v/GGWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2UebVop4icorFeB0cOpIPnw+i9Y+qIqXI6Qcjqu794=;
 b=XoRKtOc6G5ydnk4+fsu1uDidH4IbuEO/iuG3nRNblyhwCiMZyHVw6ZyWYUtdDyXWHhLUdsk/oVSr52sxlnveBJNYnvo5cvHtKijIKhXCLrqYXvIMPQi+LUuprO2humDKLf+DNVg45i98pxwPtcWac6wMBq/hy7RxtlXOSC2pqW2rFxAnRlIlzx92kOX5kuminpz6ZYf86UZExDoUpe8LM+9QgjbYFPeDVyQ6inJAu5M94NtSIMa0WkotCM0BT3ErbXuFIv+kgqW9LLX7C4ict/2MdQmxk6X2uhh/D/LfJGQU4DWE3wmVeEtuasKH16x9AfkYPLW6C3R0yU7OREvXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:23 +0000
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Subject: [PATCH v4 12/22] xfs: Update xfs_inode_alloc_unitsize_fsb() for forcealign
Date: Fri,  7 Jun 2024 14:39:09 +0000
Message-Id: <20240607143919.2622319-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7f518d-d4c3-452a-7da9-08dc86ffc351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?lJGQa2MiAS9mvgQAvn0E3/X8kcl1zJgvx6t/YhGaQNtQhrvJFDln47rWM7sd?=
 =?us-ascii?Q?cGAiwv9BfVUi80a2v0SgP4dBgAeRB2NF+5Zvl/iT26RrjDb1jQvIey3SnXPh?=
 =?us-ascii?Q?XAlbHlVuIIlCHtHnARFy1RfURMLpV93abWMmOr+reBCttaPlwJnwnjiyR6fB?=
 =?us-ascii?Q?CVL/CaYewFygPcs++95qb6BlZaTK5b5QJ7jtHAegE7+PP0tDoEp8eogUEPo4?=
 =?us-ascii?Q?uKVNXDab41y47k1/QK7vhH7qX9LIuA7pmGWq1B3RUPWSLgWDw65oH0OKzjP3?=
 =?us-ascii?Q?3JH7s9p9Y3t98VHZq0O8FgGl+ePw5onS5yQ5W0VYJvuoBiY5IEhFFBWe9mGs?=
 =?us-ascii?Q?kDHf7iZeoLISn0qaExQtLK4cQKA1cO9JgyAjPIw6PsTb1+Hnzt3Xel87fsJ+?=
 =?us-ascii?Q?IW2Yae3ghJwksF5XEW8QuyyFeZwf42GtmD2kwThYuRWDOFTGOwPSpigGqGEp?=
 =?us-ascii?Q?FQYJTg++XmHOquoiZnNgdv5KquZ7V4DtOYipQpSuHfZAgaq49jd5zl8VhHIO?=
 =?us-ascii?Q?UnHpnm2LOpmxkR85Iy0rOwwHOpEzo3/FgBiu8QfTDbRsTDvsllNx+4OKa1mm?=
 =?us-ascii?Q?Q7LYYmR4GeMjbU55sD9z7zKPpmj0QKpvOD9NB0RieYNja1uDsVAjrytevcsC?=
 =?us-ascii?Q?JwudOFtdbw85tMmV9ED1rjiUah8+GBaeZwObZ6QU/SbL7cJaB1PUFtfIp/rk?=
 =?us-ascii?Q?vPusOnuysNdzv6iAUhYCPiUyX2/N+URxMuR/2yhQ3cW4tpuI9ZdtNjipdhFv?=
 =?us-ascii?Q?rRN4T10eTzCT67siorCttFCON3pw8eAa5/PIzWr4UMmUph530ZU+mTKfMzNp?=
 =?us-ascii?Q?KRYnlm2AtLOINlnJgt++2X1HI113GkFT9ePTc7nGTWhbyU/x2QFzq5jJatm9?=
 =?us-ascii?Q?U29+GmjFgUFiUbfRIqbZjjPLmUE9rvCeaZs1wUc7gG7oEvTYXnssSObSrTez?=
 =?us-ascii?Q?Ya2BfepG1H6RbT1NO3patgs6w3QC3xVA3c0X4SQfADxufxKXA0BGcH/ZGLOr?=
 =?us-ascii?Q?Xr4FymItpajOyGY9gmki5DOdH4QZFzo0El6yWODz2ASJz9e1rZ6VcHcgfsAS?=
 =?us-ascii?Q?YFXxigguozrpbVk+h/zxt3pFQDe6aqKp8OK6U07jGTSnq1GVdE9Nffl8sFhr?=
 =?us-ascii?Q?Gs+N/M56b4B8/jGV1cfnZHmBUANzSZGhBZTEgvBcpA3omdi5edhdr8vXpKgK?=
 =?us-ascii?Q?GF8XbO9eUSoUXjCWTbclh0qrs12h5UB8iatZhXMnisbqrIhxjC2JwGUm/ype?=
 =?us-ascii?Q?gf3xJUYFAh3cQmEDTQmgmWGrVgwhW8LpvdYXdK0BW3LM16OcpkMOz1dtuxRb?=
 =?us-ascii?Q?BkzjoYgQ0bFEd7/ebJzVmZxr?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?VETOuPRLPACFVTXb1Ihyb4cdqKAc4LybRmpBBbFFd36O2868kSoFdmgXlw9K?=
 =?us-ascii?Q?zCSBXvnX1g4cj247Ild9QG4FwxC0bHq2rP0rceupWyiK0ctnZ4hM52o5EIut?=
 =?us-ascii?Q?nxUYBkb0G/3wouVEp/ajNQ7841Ik/IjsaBv0Z2EeX42IwJkVVavwBIIU+2Y0?=
 =?us-ascii?Q?/dEddIsVif1s05Evp6JWQxjawJXArUzRYzQS2TFzPGSp+9YkHAPHRY3WhELe?=
 =?us-ascii?Q?ztJCCOWK3UrCnp5XrQbPYMDEWEe/mdWvEgWvWXW48ymG15q4T1308EFhoFYl?=
 =?us-ascii?Q?mHqMfd+Go1nN0o2nnjw0zBNS2NJkBbSuMqVzNPhqkHYjyC2XznOWmhIQSJf9?=
 =?us-ascii?Q?k/w2x8BCQdH8padDbx5Qz3f+cLqno7Mplp2LKtczwBXQeT1q6RLKH9Iw6XZa?=
 =?us-ascii?Q?jkmw+FYlBpRjFUVEFhJdYW/a2k8+u6UCeYXF2d8EonA8jDPf8+Ly+wnLH4hC?=
 =?us-ascii?Q?jKMA1/l4S/kJXcoJeUPqdpLaKY4UKR6KVyO/I9ThvLg8rVbc1GyVzlTrrb4d?=
 =?us-ascii?Q?oPLV5XpdgkwlnoogalMHJV+hT5ON3NZDrCPDO/mif4tXsuhgGA5kI1VTbMr3?=
 =?us-ascii?Q?bGny4YwK2dTTGzOyxBwSlWT6kBJj2mXhl+FlQt/4kkRWNYiTvHLG4KOkQDWB?=
 =?us-ascii?Q?ygA0cye8D0Pr7tNxJyISL728zvuOp7zOjK4d8gxiV4cxTW5npYeVYgLebgmM?=
 =?us-ascii?Q?hje3hRwo3+1vijVTHRaw/cq18+gxFKrAJKVJhYZK/3vkn8qHSZL9kLNjM8SK?=
 =?us-ascii?Q?vqyjH4zCrVY63tu7o7UMcRZubsWSW8G5a/6yfgLF8rn9l0d43UTOC1RXiugS?=
 =?us-ascii?Q?7SQJzUNlGHJ6d/yrYRccZMMssFhdODMilrGlgd993ec/S+odVLxTpM2iS3qT?=
 =?us-ascii?Q?5VYtBmOTRH95ApW3k17SW5Migs8de60ZntpR1ItmPtM4dEtvkwT6CYUsVSV5?=
 =?us-ascii?Q?8BAZE6TTC3gFg0oybk37iVmdS/Z7SmnQEo31jy7yJDbFuhcZdKLuojeDhqsb?=
 =?us-ascii?Q?xXTn63yN/DRPhb6KJuBjPPcyoDoKaYwG7I9FG8T/Sxub/cZYHFP7x154bggB?=
 =?us-ascii?Q?yerVBbxJ/PHmUEwPLqgOTDxYT/IYgj12D+qkBeITlugb4037yxvd2rc2hItG?=
 =?us-ascii?Q?dR79am/KmI3kGhss2kUtukNs3AY9e9J2dsljoIXhQ5kFQtfXN6Q4Ueuh6STg?=
 =?us-ascii?Q?UcpT6nKc/mX0fOfMo+ZApQVR9ArwxYbnWE7Y0XJ3LbcwpVC73zNsfPtFxZLl?=
 =?us-ascii?Q?qEUxsmfSzSzUKAnET9QqPwCMz5tXRGtEWmUMnSotcq4vJTJjJIPbwqUGV8sC?=
 =?us-ascii?Q?4FRxuY6CM7rf3TMpS3nXbA7t9YtXh8mgC8afLdGgUPAHOinCl32QKLtdH7PB?=
 =?us-ascii?Q?jqRMGAjxf/fjSNZ5xjksxpavWvCM8D1w4gY57tqR/aQJ6WLFfnL1tvbPly44?=
 =?us-ascii?Q?XdYi89SM+9DOUNsVUNvygCPX49iulfhXaW8yQ8cOeEzusEhAQCv9xGfdkP4d?=
 =?us-ascii?Q?UVH53NDUj9BEgyTgIMO5o7dnp2y2/AAIYB38QdtkIvFApepSXrHrOfVEgzz+?=
 =?us-ascii?Q?7Hpm6XKbjRC/WvuKF3XRBzDzij6VcIueLzHHZnpBDuqnsBU5GlrooDMYiBL1?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	SuZe8SBIcBPxuIgre6/+/IkQlhC+Dx597v6q2fynBiHGf7RiE8rAPSrN1v9CjIHFPmrx4a+tVZ3Z3EsRDwRRmNaFC1lR8+EbOqie93UzE9P+0l/ThzeQaokqFx1mrkPG8nmMIoJBIUn64NZSUV5YnE36EIJfzWnd6Nx7vq6RHHXHVp9BFgdESTddLK30EYn/cNS5IacOe7bH93udAZbRQuekWtM6VjXHPz/Y3MHXr60TYE3FFgXZRs7Ud3t0bMzk6TIk0EjrmwV08U6TtGVhuDI7r9P3vCfJrJtQyqWIuvl9dwlVn83Di4mS0mFp/ApBCcSkaqFIDpl3aKikj1FcPaIAREoB3vukVuTNkIxdl8rxJm3qd30i6ITe+p+9mXmTMUR2ZC9Kc61cqmV2NIraIsBYY1n4rxLjztw8Hb/eLO41GvCHo0jYIDhBS7GmahZdieKJaAidPFAxFLTRhBR/SKlQZ1XNWmBS4ee5nVQKe3dP6iBRk/lSITrwx38FZOK9cbicyp6KOIEI0e/ZUGce14tsGBTRUD/DWDKkuec2d4vqjXiklxrUJsSKzoIFV4zU15Fv0Dz6FOMOD8VMRnp3c7td9qoL8BVhbMyW4AO8zxY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7f518d-d4c3-452a-7da9-08dc86ffc351
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:23.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD4jufza3I7sIz6W/xJy1S+X4geocPcsHQhlgJhxsA6cQT5kIAa+NsQmNUFqXyh6nn0nEaiSeQ7ytpR1WQlL4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: Ct06JoFIyOdl_YWisqsERup1SUixaztt
X-Proofpoint-GUID: Ct06JoFIyOdl_YWisqsERup1SUixaztt
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

For forcealign enabled, the allocation unit size is in ip->i_extsize, and
this must never be zero.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index a6cd5f1f2680..9c0ae5c3682e 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -4281,6 +4281,8 @@ unsigned int
 xfs_inode_alloc_unitsize_fsb(
 	struct xfs_inode	*ip)
 {
+	if (xfs_inode_has_forcealign(ip))
+		return ip->i_extsize;
 	if (XFS_IS_REALTIME_INODE(ip))
 		return ip->i_mount->m_sb.sb_rextsize;
 
-- 
2.31.1

