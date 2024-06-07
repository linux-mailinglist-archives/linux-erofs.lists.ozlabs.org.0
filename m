Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD179009E4
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 18:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1717776334;
	bh=VgojAUgaAcfjIryjnXFOxTXgxUloGI+kwqZmSnGjXg4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kKOzZkzwmHVbdHGRcxT8P0HsgBKgWrFX8QgxV5UxAglgddd8ng4ak61CRlmEdZrXD
	 NYP1rnuTjq1DP6Tub2tNks96549w7k8G6BWdLf6P8eaFGtDo10c99h1fFUbM2rSEwt
	 wbxhHImgTbiH8BpY5kTIDcfvGDaKKourwMIdCUI2O/FKR/lmIsJgz4NJjz2KCo1LnI
	 bqaDxnN3KCL3+QWKBdctk5ymkGJYgi8fTxiZKb/ijTvPgDqf7DDIm108F8IHWB3jPb
	 +TOWKD8eSSu1LGkJ6SewBOGAdqxWF0mPgGD1NzszjnynwW0zLPY9Cscbz9wvPALVBE
	 kf/Z78vxd976A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VwmJG4zXtz3cQX
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2024 02:05:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=j4EwXIkP;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=sONOY1MQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=john.g.garry@oracle.com; receiver=lists.ozlabs.org)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VwmJB1ZYLz30T7
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jun 2024 02:05:28 +1000 (AEST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuU2x023572;
	Fri, 7 Jun 2024 14:41:02 GMT
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrsdq4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:41:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ECfBx025130;
	Fri, 7 Jun 2024 14:41:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtd311e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:41:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsL7Yq1WxkDvhlzNkp9t6LAwzCmS6w+WRgD/g8gKXuYsYrheLBut0pohYphUJ/2yXpkAZQ0hiL8FFF6YH69XI+zaNdFMID4QDXQXYagcvLvzSgKVLhV3+JB6hpIH27ug4AnROHXDM7rgR0ZwG0rEy820bjqH0Clj/dS9xEeJHmL1k/o2J3f/ebezfyCSb2VDkUlnuU8LefsXHHSx+5fmvEi323TDhEgjAiJ10HOqnDSi7EtaYTdn1EhjMNjc5cOvnqpyX5EGI65nuCPu3JQRrj8ysSaorm6yLptwhvo1wh5Azga6gp3Pev76xOG0m85Mojmbgp5wzQOqvi3n2Y3n5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgojAUgaAcfjIryjnXFOxTXgxUloGI+kwqZmSnGjXg4=;
 b=cy/eK+su1oedtuu9kYVJrFQK/VFqkztuTl7H1ID//gQqySZk3BBrZEFaENNYQJkiTb3U2KxHYavdqfP1CJGU6UGCKti4i2+x6i34xFYPsqAk+E3ybR6EPU3OoSBUZSw71fqUkrY1UC5qMXhbJ0azcucvU7zGheBAtP7+Rr1E5oTCDHVA7ycPS5DUR3W5pFl/wQ6XV9BEAhJT6CEd4+oOqqn4x9Rrxig8+7DQlA7R4oHo8QdLCFuIyWIDrXQhKiR6bDD0X3W4OMQZYbioF2Ciz3KN6hg1mdq+P6T9LF6uDRSB2j62YKCUxKXzc5Y+qbdJWwYfo5WKW1vtqNsrsaIYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 14:40:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:58 +0000
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Subject: [PATCH v4 21/22] xfs: Validate atomic writes
Date: Fri,  7 Jun 2024 14:39:18 +0000
Message-Id: <20240607143919.2622319-22-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0699.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ce0436-dad7-4cdb-571b-08dc86ffd824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?rr+5JB539Wwnb5TGBoXvQwyqbnYIH3qU2HKAjUZjIa2dY8QazU/KZxA8wI3U?=
 =?us-ascii?Q?E6KrLiOQbTYgB6X4K23txENbQJmgaHF/S+YYDUdG/3lvJiI5tQM+9B6u+eIC?=
 =?us-ascii?Q?0e0+/+qTZwh3EcX99GSWRccbIQ3JBnBtD/5QQ7f8y8NdalgoO8xQa4iM+1gB?=
 =?us-ascii?Q?y07l6qGWlOipe5dIW2WgwVuPH+rxF/kpWBqCXKLbqlp/pTGGbl/eqjAl8PRI?=
 =?us-ascii?Q?1LPuJgZt+OXcBsoiYV4XjzqQJdSvrPWdtjGI/fw6QfTVch7Zlm89AW+EPhE8?=
 =?us-ascii?Q?NATad10g56Lbbw6ZY0RQZHJqlJw9G9IVQisR/5UGjPzpk6EIj3LMAZlAcos9?=
 =?us-ascii?Q?5m8C+/+LwDGTNCIK1JOjv9t8vqmZN2Sn7z8vS9YEy4oJSJ4D4gXlu2cOjE/y?=
 =?us-ascii?Q?goOTRvmZGfnNjp6WT9MF6Jwy+9G0ZRYy6RS74JaAsZBnZL9yQxW6XI3wtXwh?=
 =?us-ascii?Q?OABtg7BxSPAL0/tbxdphX7ecE+a5/2ft+Pc6YkDe0Y0M09dZL1A9HFMBKD3g?=
 =?us-ascii?Q?Ul5eHRdWrhXYiN5S4nFW0TppDVxLELwQqfobhn7CxmQznu+xeHbmyc0H2OW7?=
 =?us-ascii?Q?VnJaQ0IbjDWyHE9u1bxT+0prKXUw/908KFV9GQRVoc2AQzpJIrOf9PyNqNFU?=
 =?us-ascii?Q?D5q+R7MtZuEs1zOVJOYf/mIK0t3yUvCwdfxlsgcLhr8KMR68R6bkJKnjVSIm?=
 =?us-ascii?Q?SoWv8KrmVJHH6Eg0735RjF/LGN3qEVq2bcM/5dL05qjPPxRVXdbMPjjD6QAy?=
 =?us-ascii?Q?3rFuy2XefU0yLvfFKx2+DGt2/fBZXmJEirZK/zitDzsR5ez9t1FjlClmtQd6?=
 =?us-ascii?Q?Kc6F9f9mnwoqY9pxK67T6rumdXBkINheTCRlMNk6MQb443ngPv6ifwf9kCBQ?=
 =?us-ascii?Q?SU4L5ksZzW/nSkR45+YOCy5WmUX7/d8Fs0n4SCv/F7sGJ7rFnVSjF02LECqb?=
 =?us-ascii?Q?jUAfzU5mDa3ethuUbg5XkQasmLQWiUezDBVS69K1V8Kkh/ni1lR/NFJgYKYS?=
 =?us-ascii?Q?imiQDxuk49EKSRqneKMU7w//z91JyP4MvUCXOkFDceqHAoAVr0a2/zpHNRS5?=
 =?us-ascii?Q?zPkmceeuzk95dBs7cDjQ1vwPdTcQN5M1XKRontqtSj4ttfZSvsK52CW59on6?=
 =?us-ascii?Q?93YaQn6i195YQ4zF5ZJr1+FmSdjMVXQ+4eJA2SO3F4vaYjXK9QRc9sob3ovY?=
 =?us-ascii?Q?7eKkq0noDUYMA/xUrehcxivvpuTblzULeglnjxtrLt8nKYeH20StHIoH6GIs?=
 =?us-ascii?Q?yDyZ5y61Fo8kfPcUa13CmDI1d1VoADo7xv0lEz+4Opog6iqFTg0HNqKEyhf8?=
 =?us-ascii?Q?9YTyWJjqkD2kEp58bqqVhla7?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?2nD1oK0zgfV4CTSsSxS0aPUXU8Qwe+Apf+g0ccRzanTgJhjSr3hk/T8jw3rr?=
 =?us-ascii?Q?VpUHkEG2u8xGYEazqur1BBtk9rftdRJ9tIMjCGa5+yjRZB+dhXf8k6ol+6Rj?=
 =?us-ascii?Q?LnLvQrpND6f9+a86jOXFgZdxr44tDaYY9cehPkNEm4bYECrayUdqfIrlD8x5?=
 =?us-ascii?Q?wEh58dGVwNM4np7tsbbmMoEMhqH43vZrHiwfW/VCW5Cb8tosxxvvF3KB1sCV?=
 =?us-ascii?Q?YNR3PgTc2dtq3SFqlTGbixKWQDG3RMFI42Kn8h5NmTE4B3KXcsRwtq8p2Yw2?=
 =?us-ascii?Q?EoGRTAZUFNlumaMkW0Xg8C4csz5Rt4p9m6DduXt3KeS2bbvldQiYoWdracf8?=
 =?us-ascii?Q?e7697nEfUonsMO96kl4Uq4JHGXhj6aDQND2XMw4H2hyAdsuVzzIIvL3zlLXE?=
 =?us-ascii?Q?XGVka+mTKep4mWsvNllRxaDo9Bykg0HWfPZHiGrfgq+Xig7tL8u68x0HKA/3?=
 =?us-ascii?Q?fY4p790SQnYdRozeoQ5MTM9d48EJEi5F9VFGXDhE6ytD+pL+rFR9yzOM8qHG?=
 =?us-ascii?Q?YIDrDFlJJ990h/iSAyHkaf0Cfo58DQOPxQ1WAZiFcHTQSf7krJd1ib/DYnQj?=
 =?us-ascii?Q?W+esQlNdLOthTET6w/0mRi2AuKTnX5p8luNDlTpXe61IGo6hm8jY6MLIhufz?=
 =?us-ascii?Q?G7je1Qry0OJJTHOiO+3d5SLyK+QQisXf6Kh4wd4GTeXF9gs5Ewx+kime1RBE?=
 =?us-ascii?Q?+Q2wtt2l0H2VYC5c3VegF2cdI67HXT36hcw9gbHESsHQlF0fTTMtlkMB5aFw?=
 =?us-ascii?Q?A1cc2s8ml/LaPFCI0y5VRboXQz6zr8pOF3eVTG6NDAQdMBq5zsOr8Q5x5xS8?=
 =?us-ascii?Q?51a+w+KwgA0OCyH1iRAPrcXh5myFe2bCIfpXvlMy9uTnYBony64q3QfOa49V?=
 =?us-ascii?Q?Q7wIjyPx//KRK64pCNegEttk3fRyASIMm2uO1Af5bdgM3Hd0NqNi2ivGtGG2?=
 =?us-ascii?Q?i92d7Vekrp25s6XYe+b+sCii43vEb/uh3MeoGw00bz4wFrGi+p5R2OBl+pIj?=
 =?us-ascii?Q?kieunPOMbbQKWtIrSilII+6YUbmRT2geIR2KXGR8JA9coS/RW6tV78C23Fvz?=
 =?us-ascii?Q?+Ig9p0jWnZQKHe95gi7XRyauOK4k3kUIG7GGBhN1pBYAEpQ3/XinWZor+N8c?=
 =?us-ascii?Q?T1t8mfiQr3EKucecWXCoLBJLLbjbFzAhMzkWc3xiqKrwfUgJFiR/I9E0qPJS?=
 =?us-ascii?Q?LSebvaQdx6q5zsBM2kLeiyZ0Y8hevILGnfl58ZHnVmbN1l/BV9X1q1yUtP4V?=
 =?us-ascii?Q?VfTA48YPFStZaZKGAN/VJDDPw2YCZSZFMEm2qScninarba57c7t8hSR+LBEL?=
 =?us-ascii?Q?lGvXtl3q+6df7aQQStFVMXJ0vg4qQN5KqB4VmRqoFb20NzF4boQIvffjmRGa?=
 =?us-ascii?Q?FHE3U2YGWr+c62ePlXi2D/6r5xkjEig5q0Fl+EL99gG2O7dFbhhGWxAmZ6Cs?=
 =?us-ascii?Q?iF/SyRbRusHIE7nzVZL4CvtLWKlSfVtjxWlPmSdY/s2viyYV80QtDFDZ5Ytk?=
 =?us-ascii?Q?WcIORVMsEws9LPNaOq6Y90lQCQFxrY6vLh5iOxaRh8OTn91GRGI6CujI3T67?=
 =?us-ascii?Q?EkuDJWInsMxl2hjLicQKC3F/GiBWmAt0nlqDd7Srkin7pkgfe5HoCs2C9UIm?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	eg3UAEZav3RtbeUOKPl9tT+MeZel7rkDAOLqE2q5fmZ7sw9Ul4ggDU3A4laU4Bt2UID2/qTu/iWTbrCcBZtKkDF2UszSRdiH/qiVs5cQnXJuZU4/A1j0XN0rYs6IEVHQvBB6hp+dlALF05eYWgW9zW2j8MowHpvXtqr/Obu6+oBBb1Crvi2eAqMLEbEIndwCrOglVUKvLi/76YWGArZ/bckAgPPhg+5hjPN/5X9Yz+eTfHUBMGGdIfnpbnfN5uG6wDKqyqmDnS0zUmRIobj84ZQ92gkRPrbwLil8+2qlkagBiIn73mZkkFpWmpaKnHa77OO+Y9DWnM2IZeqvw2i0NEH7xIVI/Crxd+k5rGu/WDzQsQimfgjnbxx+vxV2/QTi2F41Xx3tsMeTYSA6RnIMcDp8sJhk7M6Vgijwzd1TM0ngbj/wwv4cqRJpp5EYjLFsovottC50cCKki637Kckv3GQGZTmVry1Uee8a3ahbZX0TaRr060Lvk9FLkF3watPZnlsiEOwGQXnZ+IKQ416ChUjOK7f9exy/olWqSa0fDTKiPlCcrcSgzfZy1v5uYWBWxtwjrTZjGuIel+zwhwGM8OaEkgrQOb9pAzILHOO3xUg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ce0436-dad7-4cdb-571b-08dc86ffd824
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:58.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G2zAhJv5O4i1KFsC7d6X0FVd234THaYKIeETtwI/aDDDqMGUrn/h5xCANmXpw6AVi06U6UOlqdWMgVz9FEPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: NjU2vKhpZ5KpoBrzPDkX7wFqJ9g-hZ3n
X-Proofpoint-GUID: NjU2vKhpZ5KpoBrzPDkX7wFqJ9g-hZ3n
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

Validate that an atomic write adheres to length/offset rules. Since we
require extent alignment for atomic writes, this effectively also enforces
that the BIO which iomap produces is aligned.

For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_dio_write(),
FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
FORCEALIGN and also ATOMICWRITES flags would also need to be set for the
inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 24fe3c2e03da..eeb267ae2bf2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -695,12 +695,21 @@ xfs_file_dio_write(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
+	struct xfs_mount	*mp = ip->i_mount;
 	bool			unaligned;
 	u64			unitsize;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (!generic_atomic_write_valid_size(iocb->ki_pos, from,
+			i_blocksize(inode), XFS_FSB_TO_B(mp, ip->i_extsize))) {
+			return -EINVAL;
+		}
+	}
+
 	/* direct I/O must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
-- 
2.31.1

