Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A921E4867BE
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jan 2022 17:33:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JVBkT3FwPz30Ds
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jan 2022 03:33:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2021-07-09 header.b=zlyyyThj;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=pVwmWFOF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=dan.carpenter@oracle.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2021-07-09 header.b=zlyyyThj; 
 dkim=pass (1024-bit key;
 unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com
 header.b=pVwmWFOF; dkim-atps=neutral
X-Greylist: delayed 5023 seconds by postgrey-1.36 at boromir;
 Fri, 07 Jan 2022 03:33:47 AEDT
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JVBkM6W8lz2xBL
 for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jan 2022 03:33:46 +1100 (AEDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206DfcHm011535; 
 Thu, 6 Jan 2022 15:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=ogTyZw/v4tAh5TUHIIe9sjxWq15lv5663OSTghHrCg8=;
 b=zlyyyThjZ4Lhjz3mZCX3awz+e4Uo+9rlxaRN3lPfs/5c/A16jFGESUsTzc2gpx4JgYbV
 cq/yIyi2OLK58W8XaolMX41DbUyaC321p45rcPH+uWr5tUaTN6eOllegdIWm5QfnkhF3
 JP9oQga6a6t6m/LdL/1Sc/5O1z1K9oPQxRLraFTbJSq4kuzXOH2HwdTrWlLjLCsjOrfi
 TllqES8o6L3uO7WQerBqWWL4xRn+0x2C6J1ZUfGFJHsjo/HyuqxbHHxa6CpZEfkxf9p/
 yN11v4X12ePHyEJk+9MTERRRh4F6T2PHS62CKUNNkiM3sMr13xuHFQvdVigAX9R4B53q vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpmhvtv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jan 2022 15:09:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206F5MVJ129974;
 Thu, 6 Jan 2022 15:09:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by userp3020.oracle.com with ESMTP id 3ddmq6vhcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jan 2022 15:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvCS6zaACK+cH1yky/fPOX62cFkxbzyMonmablZFnDwGEvf+EY38n1W7hmgcek7qTfZXq/dcmak1k/Dvr3NtjJGJVgahMEhov6racnN6PdFxneb+qT8jLeDpNScZFKNFO4K+nVYsd49HFRHqfZrxZcT2Vl2U4zfwOkeOfVzZihhVFyHqPo0uJTc7oI+fI1mCgLxOTIjOwtBEVLjbdjDIweI72YUa4okcslROjm4T4/NNgpAdcO6SvAxqWMP49i3xPk+GwjdcXhg+mh/dfVDrSjrnpCYSfrhUOKFHalLHazE24mbEEYg8gCL6MTFBa/mSuTHAN6XftPTawmZrC4zq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogTyZw/v4tAh5TUHIIe9sjxWq15lv5663OSTghHrCg8=;
 b=HGreXbdCzwtcf9qVG38Nh4qZHxEWV/ZEGJ1UaX7geWwrkR5dBo1kBs9Tcm+hqeb7yL8y6tVE/XLDF8T3l1v2BFmNlj0V+LTrXp4m+PmAkhn2XVTcCjyZ7HQuC/G8I4rHL1ode9Og02Pjmv17vwXtE6W3SdvFkxRaYbkdbDh+v4TyyEnL+7DTXG9SxWOhvNBxBgFkaA+NDZFmhmJvCfXbazLLXAZX+ZU8JC8myiQ3s1N822uxP4+T9qNJw1tf8/Ehrwb1QaR69BRupQdNHJOA4EJ2ckGEXmsFxJ6dDKJjh+92L1fgOrs0t6uBZNfh6lwNQGE8XAKxUmqizYxf4/5NSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogTyZw/v4tAh5TUHIIe9sjxWq15lv5663OSTghHrCg8=;
 b=pVwmWFOFGkaoIzFRktUP/iHGnELn8Hh5FnvChzTXkqfbhx9MZN75l+2l1OcUCxjDpzpOMdebvKWCYUHpW1sBKb1Yt5Nmw9eMolOV0Tr7qig3zmABmejSOYQ8lkprG9QBbLgNFfcyAw5+buBEqTCJIeyhKpMUXZBWVrAXXOLX4s4=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR1001MB2392.namprd10.prod.outlook.com
 (2603:10b6:910:43::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Thu, 6 Jan
 2022 15:09:20 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 15:09:20 +0000
Date: Thu, 6 Jan 2022 18:08:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@lists.01.org, Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH 3/5] erofs: use meta buffers for super operations
Message-ID: <202112310650.TDDinvVT-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229041405.45921-4-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::6)
 To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85804763-8e0d-4f47-1aaf-08d9d126839a
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2392:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2392E615C2470736223968188E4C9@CY4PR1001MB2392.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oX9T+sUGWHUwGjChRzA9IBeoER9/cpgRlGAmpxI6iBNAO4u+kd0RL5MV8WvyniqbaK8NPWh6aNJe7HdsB86+wMtAVmAGXpHFUI4phKI59pHlKeQ7UN5/aOsZnsMnz2C80U37zpWjRP6bTHqTZlB7hjFoAHANpYyw4vUBnoEJ279YbGtiPzGnQKn5QO+0QEETsfkmyVTMnyyje40pVpSyujK6x1jJ90mI6Q9oSDRDbBbD8pD0vRoad2MA0Z0qPzwf48QrqUvYYvR7SoSwW+aXPC7eN8EjjE4j+6ZvKonYN7MQO3IC+pmHk7ujsafsbA+8sROlgE1TITUks/qnnGqDhAVIaln9Ef9yhVhG2SbK2pZAzKMrB33NX9BxfPXK3IevMGjOfvxFBTzu5NUme+DsPLsO2wA/LrTrubB8hbLdeOtVKHuKpPq9sh0Ya/mS2M1TAaMCJW0voSrK6660p9pVAeuQgTUV424YAY4GnVroCJ54CGZi6mm6Ujb15b4V3UjmADxjrsUMucKChzItGqBWdzCy5QEG2lFCp9N8qV8OIMyVcYvGPoNLPqLRB1ADopivQyUIJxB8KiUsmYtX4nB3TF9xi64FguOea8QdGc27ZgyHx3YPtIo32s28ClJ/1u7yB4eY3sOGO7yrj9KgcpZoVKM++xjV0nd1R01m0qQzZVoD52gg75XZlum6cZItFFxif2HswVVt0P8i0XxmfW2iijSi60wEw049iVtqXmxdSPArBU+rbPHNqSP55tJEgcIT+JmEbD8UdlZ7wRT7iv7+uOqd8EnNGDi/xWOrMjOTNoPtfaY3hguKFe8jju5p0XME4jRTYLONj4B9D2aDJIB+Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1001MB2358.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6486002)(508600001)(38100700002)(1076003)(66946007)(966005)(9686003)(5660300002)(44832011)(316002)(6512007)(66556008)(26005)(66476007)(8936002)(4001150100001)(2906002)(6666004)(36756003)(52116002)(4326008)(83380400001)(38350700002)(8676002)(86362001)(6506007)(54906003)(186003)(110136005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vtcMdG0I6vWgJjUKmxGkHscyOlXEqsL7cSV5Lcj5HIwXRBIsYYHo+b6FYYV?=
 =?us-ascii?Q?A5kiZh4PSjyE49NQvhL0MNE1RNmem5zCFVrj7XI0yL6UTbOfFY1wlRjeddvp?=
 =?us-ascii?Q?4XyR1y9UYZ8fxhs3uu+TRHrWDrexsrbbxWH0pdl4+Jiibf6TOegZkzMZ4KEj?=
 =?us-ascii?Q?v5hhDQ9xC6Z3IV/aTyAwZmu84Z3PWKCkmChFYrrIpIAzZjq8P46fkXQKpEfX?=
 =?us-ascii?Q?Bq0d/3fiKPsqrgWvK4kZyj3sumbFwsiIdj/eCb3409TybvYwdG3dvN17eTr9?=
 =?us-ascii?Q?9Minyi/IuypxYzmZMb9kdgZ9ITLTCWaVGUf7hwpr9BEEY9KvcNzIq6Z9Q+6x?=
 =?us-ascii?Q?EMu1PlPrAedBeFPbCAF1v+0G/jvGt0NB1ObDWbe1mbXzv2DiFhrXgJ11/5IB?=
 =?us-ascii?Q?a1KLthurJ3IxntfK5Xa5cJwSLzUB/h5GOXh/8ye17R5MaMHziU9WswalpzjZ?=
 =?us-ascii?Q?qQq0/bs4xQIlZHvzwv98Sh9dSMSymwEC7J2OQVCs43msICTkuw0OztrMtvhX?=
 =?us-ascii?Q?OYvuBj4L+CNeWiZYEyUUXU043924IwYoUQco65nJ+IAFvNNUIlRJl+ek4fWP?=
 =?us-ascii?Q?yhwFWIH6Pmo7h9LcyXKwWTSMa+28SI6WrL5oq3omceFEBLtlaD1liWUCpQ6A?=
 =?us-ascii?Q?GuZmRVcM/5OuZyTieGSXFPGi8+Jnx1TadvllcPS2tARb8O2YORclxeiEsJFD?=
 =?us-ascii?Q?DeXVSOfh0CEJNrB/AKKztaPFFP26paJhuKwDG0oXBoc33n/naX0BeSLz5LDl?=
 =?us-ascii?Q?0q1sjzYpKmcXPZi5RFKtkvs1B6eWgwbI1O+McA34xibDfUzIhQonZT6Yphst?=
 =?us-ascii?Q?03s25FIUyJ8XSSFjm+X6K4UtWmU/Ly3lQqi6fIeNw5rYWZf8L5gMz/Y98u8n?=
 =?us-ascii?Q?WCcSLWnT1yUKeCgMcpat2J9zkRlKtxQT5iDm/9418BZim3SMLAUY2ugSljb6?=
 =?us-ascii?Q?fkLlJeHUoJwtmu1pZmzP0zFmEGh7Xzq0/gsCPRU403VmihRquCY8pCTqJVKA?=
 =?us-ascii?Q?d1h8b4uoboIKF4vCniV1mXJHBYoJJ9/f+sOKPnNOlYqpFjUQ6dMljDsjKu2a?=
 =?us-ascii?Q?jQQAe/OmTW6ThYDdA6zz7vUS2+4lUd2M+0zO//6qiz+crB6Nj21PAO8Vfqpe?=
 =?us-ascii?Q?c0WnbEMl+0BlStQfHWd65YqEVi33qUBlJrY8w64VMsNuhBRi10yZPh0a4HLE?=
 =?us-ascii?Q?TJbQf/UfZ5jGjL073bgJGVwPdyEGAF6I2HLDpkp0aqyTVG5JdkM+7OimFc+a?=
 =?us-ascii?Q?8O4Vj2qdfqpxHnU5cY1/af/XBFj57OehTM+qL2pfaA0V3SVT/OZ5J1kk+LnU?=
 =?us-ascii?Q?N2p+nE/ofwdksuYfPy+WhK8pRxKKmdhMuNZVzbdWiQ49j1HFa//zYPwIIOL6?=
 =?us-ascii?Q?9j7bWwPT/mf2mmhwOvH7lfkm7dMIAF+xhXR9UhrlVaql2eiGV4vcd3somj03?=
 =?us-ascii?Q?XjcjBQWKg8QTUOvfHQgZ0IJuZDfLCNkunDXGh1AuAA8eOeRviXbX0N9P4UA5?=
 =?us-ascii?Q?boRfvM2VR5HflMd4GEyZuLoSo997eOXWdTTzKLtjlMBTcbTnlSIZF9MGi19H?=
 =?us-ascii?Q?XF4qxooNfjyHFhsYaXAApw+/qmYKoPvQxbxvkOSdFNNnJhBclcHPkEPXdwD/?=
 =?us-ascii?Q?IqPKwN9/n2/PCgJzFC+rLJcsqV2AFFQClhT8CRfcsBOFwMHOALo7X0pnO8l3?=
 =?us-ascii?Q?ud87I3HnMzmj3eBgHfev6kC+jJ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85804763-8e0d-4f47-1aaf-08d9d126839a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 15:09:20.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luE/aB/Ux5RW0HwRnIjdSJOEebT/owMWDR94V4DyWQp/5hco2SLVQ3w4qgwxVnKIkewqSEbibOuI17w094g4P1OnV4NzQpUpQutv43HPX2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2392
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060106
X-Proofpoint-GUID: wbpfDWvDggeNVy2n95EP2iNGuNYutnUH
X-Proofpoint-ORIG-GUID: wbpfDWvDggeNVy2n95EP2iNGuNYutnUH
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, kbuild-all@lists.01.org,
 lkp@intel.com, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

url:    https://github.com/0day-ci/linux/commits/Gao-Xiang/erofs-get-rid-of-erofs_get_meta_page/20211229-121538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
config: x86_64-randconfig-m001-20211230 (https://download.01.org/0day-ci/archive/20211231/202112310650.TDDinvVT-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/erofs/super.c:153 erofs_read_metadata() warn: possible memory leak of 'buffer'

vim +/buffer +153 fs/erofs/super.c

6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  128  static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  129  				 erofs_off_t *offset, int *lengthp)
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  130  {
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  131  	u8 *buffer, *ptr;
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  132  	int len, i, cnt;
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  133  
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  134  	*offset = round_up(*offset, 4);
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  135  	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset), EROFS_KMAP);
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  136  	if (IS_ERR(ptr))
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  137  		return ptr;
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  138  
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  139  	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  140  	if (!len)
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  141  		len = U16_MAX + 1;
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  142  	buffer = kmalloc(len, GFP_KERNEL);
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  143  	if (!buffer)
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  144  		return ERR_PTR(-ENOMEM);
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  145  	*offset += sizeof(__le16);
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  146  	*lengthp = len;
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  147  
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  148  	for (i = 0; i < len; i += cnt) {
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  149  		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  150  		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  151  					 EROFS_KMAP);
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29  152  		if (IS_ERR(ptr))
6477e408d41152 fs/erofs/super.c              Gao Xiang 2021-12-29 @153  			return ptr;

"buffer" not freed on error path.

14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  154  		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  155  		*offset += cnt;
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  156  	}
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  157  	return buffer;
14373711dd54be fs/erofs/super.c              Gao Xiang 2021-03-29  158  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

