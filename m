Return-Path: <linux-erofs+bounces-2098-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOygLRChb2kLCAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2098-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 16:36:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF5E46325
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 16:36:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwWLK0jQmz3c8x;
	Wed, 21 Jan 2026 02:23:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768922601;
	cv=pass; b=PPMOWgqvwV/tD8lLlisXaecWsNPDNZOAwR5DVkNNCwPUaPeh1SLXCftJxQBZexDJgludMkiLm6RXPtkGiqlnBBCIWwSLWQM6FL07exUYIWJsvr0Y1Fg86Y0tmRW7DcMidi+Ce+LiDaPgxT+wUHwN/gnXONtiMf17Vb+y3lZaZVMHFs9i7AYSVPahRe+u0J3Xy3jAiKp09qo24/tiFWYY2Y1ZscMEb/QJ/7yqmLWM1Xj6UzKllGpcoUeoMC9w2EhTuggRo/Vv8u5m0ZjJ/vfvBAJwTvgYr5ZgON6yovyANBGlTQ8dZSpWr1SVBhN3AXVVrFOWDOwTRrVIwimOvFzeSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768922601; c=relaxed/relaxed;
	bh=XS/Jw3z4S8CbDr8yBFqBv2BWH8NsIXN4rY4iWcszBm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GrSl/H4OSsynQCQ7gaOuQRIrVR3MZLU7dQPlui1R3XRs6lnkg3nIbY+ZzhF347eWDdZGaZ1Chd02hiSpcBpjrxLsga05CRzKpVCSl3uuzkioMBxL4/wZI3botRvGAX2ZVTBLdl7mUqjMpxbuIp9Vm0854oj7sUllaOSTozBIFR+OlIsLDEijPYYA1napw1DAtcyeaQW+0OPruo8HvTHvg7HNyp7D7qQwoAvpeRGJEca/0j+oop43OpucxxMU8MaaKatJVrhl2Ax1lS6hfRz6hc4E+wknjWqxW5saCU7tRAgAyw66jDNaG56qaBdEznHto6geH+IWwpYGo/24BeraGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BatpiT5w; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=jgg@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BatpiT5w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=jgg@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwWLJ0J5Wz3c8s
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 02:23:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRuq5sr9xXC59IWTzbSZs2WcRHIbfaoPX3RynLIXA/FZOlgvdugioIW37KPo2/tS77hqfOFhnb95EqAv4n7hzsgwzI+OE2N5A1DBxUKZhoUA5eHc+YqqVUU9+tO3WvCoVQcGhBxlUwb0FlS2muROC8Jk2OsqtCuNww4OrTRorUxKFbc563nvQDebyUSCUruKaxmuxD3ieAcNiMKH6VdoqRKVeUH9hjthk/ZePhDiHWJ5qMM83+Yu33FrVhhfnlXHb31d/GWmkSPYhI9YnovdfstOaBD9Nx7BSo6Xe/0biNgjJ4uKq3C0tmtnRmTIrdhOtspxIq13LqRIOJEkgvXenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS/Jw3z4S8CbDr8yBFqBv2BWH8NsIXN4rY4iWcszBm8=;
 b=TEGC4lALJwBwE/9Zt+ay17nHtvZZbjfMDFDbhNbO6gRBPcjj6ohQ+M377j1LzvzCmdKKLKjUeHSl9jPnPzjk0eXcrxHl7T0B3Dk1/v0g8aXHM3+vbTQBdScT/c2xsUgK6Gb86JMpBg28uOrdw4RFZDHG2/HqQFlTy0xT9TnVrMQSVs/qEseCbu8bhZcIP09WMBkh0PGbdmMqQU22c6oQAr7FWfHzTtz9RIFvVRTk1VgKtmM0A0RnQb2VSiFzsKH5USXrhwWTqpeSVzLi5/wsOSXj2LOAhU2P4HbdGu3k4CYzDPV1LtYV1qKrvPReHWQY9C6deGwoyc05iLoyGozqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS/Jw3z4S8CbDr8yBFqBv2BWH8NsIXN4rY4iWcszBm8=;
 b=BatpiT5wxfqvOok1Q6llgVzWiOEqlxOiVXaD9CRKdqRlof5jySxNAC6qiyNKQF1NzjBRRgLjLaYibwrKpuM2nJoL16JnbxHxhWjrSh0C3m4bC22HsT1MCppZdfCF0iFrTt85eTUsc0yt/43blY+iT/iNtbX0ZpuTmu7+4HP1Ena//EtuScTQ5naZH9WNKsBSE195mJUGk5VljULtVviJ6fGO7oJDX/KUiNO6D8juKJKeGOcH01BcNjdZE+WkNPhTXwHlG8w8gFop2cAjzwge2T1qDoB27ZQbpjros62/yu/n8wpkR3maR6EZpptGaC04iPJbREvYOgeT92b748TMvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 15:22:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 15:22:46 +0000
Date: Tue, 20 Jan 2026 11:22:45 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
	linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t
 only
Message-ID: <20260120152245.GC1134360@nvidia.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
 <20260120133619.GZ1134360@nvidia.com>
 <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
X-ClientProxiedBy: BLAPR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:208:329::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f23315a-38ff-446d-dcf2-08de5837c3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r7/Chpr1IksxhPJwyfuAbHS5ygCLDBPt3GBXthlBe6RpZEgxhZDvK/EeXGxY?=
 =?us-ascii?Q?oC/10jmPbTFepyeay+zIJL80Jil+3Z4vza/iRF8KuWN+6nMaCJF/lv9xpTSH?=
 =?us-ascii?Q?lQkpWtN3LctlXMe0rIfTKjOxvdoElVZ3qwJnmDJ5y3/i6xnxEIomBWJw6h/z?=
 =?us-ascii?Q?de7BsZ7aCLTA+oVeYluyyM1roYB51VrjvZhchUJIOQdHl+pNJ9NrzsKkz0B1?=
 =?us-ascii?Q?Wj9TtOXC1dUGoIdZALrlcudCpkLyogrTU/pXYcUagZ66z7N//trTn/AkzM9w?=
 =?us-ascii?Q?ABdXafmkX410To8JNxpPoseSKGP6DY2pPiHs02nd0Y1fZlKZBzx2fwgeMGNt?=
 =?us-ascii?Q?vh830RlY9EWbFjWf+BM9afSTmgL4sVgSAF4bmnDS1StzyDZHgVpJC5VofvgE?=
 =?us-ascii?Q?wA+/s68acWDgmDnSfgSnBu2J8IBGaxpkpIdAQRa0Ilf/sQkZtkKWoYQdg9fC?=
 =?us-ascii?Q?HxaFfpyC+7gRsjPRMdcAnGHtW+pY+MdN9l7uB/xK0HzXkMUyW7CUzuyTf5HO?=
 =?us-ascii?Q?STc/fio2Gdnmq0i7wb8lWBT5wTACfWfOjLfsKIU7eS3hIOshP6lfrn8jKiI2?=
 =?us-ascii?Q?LNxiatqpGtCbjALHlLlWFGYm7FCUesDnBeC6ADwJhzMCIB1jjXXAqkLk2Pxs?=
 =?us-ascii?Q?MRYCWFodXBj7lKQd1oB601eySZKPv8cEsUaMSR8X6WSLwh31Gc6XEqo3CIBI?=
 =?us-ascii?Q?mHBZILNttaOhZtqdgb/BQ3/M2uSHUeKhhBi+7IQmFLdM3HG2ZXFf8iTzFT6H?=
 =?us-ascii?Q?wbwzEadcBgY7Zj86zSA4gbNa/x2vbSMAGSAG0FH/K/xL/DYf9L12yl6O9I/6?=
 =?us-ascii?Q?sMzYIQL6yE8PqedOeKV4wmHLucAuRrn/tiPsUgH7EMXselvhW26zICU9GIw+?=
 =?us-ascii?Q?Kl+KmHU/4Yuj597FdeaSh+AIVgCYYZoWkPSAEGLr7XAbVbgrzpGHZWA/xWMq?=
 =?us-ascii?Q?KRzpiF6SOX9DxBJe6JskMwXY9p9/MsEmX/jUx4HrpfjV2lkLJm04o9PTl+c+?=
 =?us-ascii?Q?JZco1lxEZdnGQY0Z+okRwbd/QdjZ6OzPGPc7Rcfqpxmz/RZtFiIxg253Jt9L?=
 =?us-ascii?Q?qduu76k5nvng9g7whsgXVWJzpy04EY8ALHfwrv2F1kEuVdRpIBZO1Y6/4o7B?=
 =?us-ascii?Q?AtN8neBpLaPuPgJ2VO/clt8vXv0jCI+cTWUzZ4bk0hZ1mwmTJJN5Vu5ODnUE?=
 =?us-ascii?Q?ZsxNezFcyj9q8zcOyXQJeRj3jeh9iplYgKvWQAqK4gkl8t7qJkXvkCPawdoi?=
 =?us-ascii?Q?XVtQgm1v1tvqiTBpwLCCmozkRnzbnlmzqqMwHAfrw/ptTu619PcC9j8GHG/H?=
 =?us-ascii?Q?p4kOU3HEDzEwFaw5lECO5pp/3BA5eRBfemBf7MasT14pB+MYqrJaSC/nt4+T?=
 =?us-ascii?Q?L/i3JzM3M1zY45ykCZE1Ubb+uyqH1x0bpnE5wf4I6GTsca0aGri8rpxO3XXJ?=
 =?us-ascii?Q?ApAtfRwSeV4iM0waUe1oK/XI6/l+sSmVZLVTzUNwJ8Zbc9Srb0fH+wxud06N?=
 =?us-ascii?Q?jpTZ47xCQlKlrNrMyzR57AX0I2wktbpt1uPEn1PopWme6fnrtG4xAUt7+Bs6?=
 =?us-ascii?Q?6cthP1EFkageLU4YZGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kJlt45gk9FgL+tTa7H+v4SFi+ZNQ9RsaoVOCXb/xzD3J64tWrLguNA96P6G?=
 =?us-ascii?Q?7SST+nPcDjISbyhaWneiUsBduaQhlMxHIRTYpCbkR5ghoXHbmRxp0h6Y0rI8?=
 =?us-ascii?Q?5I1vPqVYKd9wyrlZvuBYCEHNhzb8v02soHih+e1jcOYjHaM8tmxBOxxdGYhD?=
 =?us-ascii?Q?ZOvK6ARaLitcB4xpNvAjr5WcziN3Yr5+LnScixjM7B8SG6vvlppcWDjnjCbd?=
 =?us-ascii?Q?dUFEizcOiryu8cA0F7idsAn1PHnIIOnG0f09A6dWPRzW4bI8FLBmcfjwGNGK?=
 =?us-ascii?Q?XUfqdoiwjYbYi7nv4/ewu5UoaVa+xrXof2sLeBHA6i1Q4cMcGcn5Ns1MVEaY?=
 =?us-ascii?Q?4LHrXFFwn4EzKMdl11tiuzU7ktcWjcpYVN6aGiu83kuICgyBCWqLm2UnD/Ap?=
 =?us-ascii?Q?6opnmBFoui1CWXhSu14dgJHnnc6tYBgtKn2g71qXeMTGH96nqb8NkyBTkHYE?=
 =?us-ascii?Q?N7iuF0p3z7zMq7DAiKKcoduoxlaIu2q2gmPqXDH5rgb5Gwy/xX4pkEHiFwov?=
 =?us-ascii?Q?Ms7jzTk1126qiDQH85lAo1hw7WXFfXgWnGiMNz4OhxT3f47Hjrqu+WkfWWvH?=
 =?us-ascii?Q?1zdj4r8o+5da5bqEmu/ewgOARhZNK5vMQPKXU9UBWpD7I2wkhUo0UcmlJajN?=
 =?us-ascii?Q?69fzw/1I8B62NTd052ztVbYcJGHxljEp95ctXYYKZAseaqIGERg3gFk7xcLk?=
 =?us-ascii?Q?GrMs8EL1aHmD6z4FTIqWFRsG2dhH/cJzSqk80BTXXcYLSW3WRtZmA5kLg8Ax?=
 =?us-ascii?Q?oltduum7kR6adFTgODVGaw1VtaVUIaV7dTfwu5A3wRIR7ueMTZaKTwUTrOo5?=
 =?us-ascii?Q?Kl8rixBk2M4PHmnHqWq4uDvsYc7xmy6lE2ZuNPiroHCGDnTfIxXE5eZHM7r4?=
 =?us-ascii?Q?HpXYmhi80yWHHzWad8ys+ZW5UJ51atEMNawupsF8sC+7pYkI/Pa+vLwx+HcU?=
 =?us-ascii?Q?FC8qKyyQ64BUxTQBraipnmobWvBdkRmJoPVdH3j0rLsPhaQ2Jb8+y0rGrnu0?=
 =?us-ascii?Q?EzqOu2cYeTwB2EPwaYgPVnB8eQmDZbrT6uQuQpiizfYA3Do2zC0OOnH3MAgT?=
 =?us-ascii?Q?vVkuIljFgae+LyGOTwJms0I/DFolgvgDKnUTJMq5GQn1msGNxq/0QT8MI5+s?=
 =?us-ascii?Q?l+iI9fQt/UfCLcMXmbhMzHq9xUOFG5+p4xKU7fJ1hijPnvjebxCZk6z3SjV3?=
 =?us-ascii?Q?gqmxfyCNLRswvbcFcnZdcLYfKeL3ZFYyHwZMno9SMSx6FJFekEg2n2pYrmSJ?=
 =?us-ascii?Q?zgSjrVqnWokOEsj2ZaNfvG9DmXLgQkcb5lr4lw6JzJ4blJg4d+crgXKFj8Dy?=
 =?us-ascii?Q?WHL1CvzXAOfcXDnziLm3lSiacKn8NBz05dU2yrrymizA1ZGf5KAGE8n6YGSf?=
 =?us-ascii?Q?o1cx0OAhg1FACHHxiiPEA4Qg6i4p2+FQce47GILPV4Bjs53EZjUUO/cSI5hH?=
 =?us-ascii?Q?xwQjiswzcAIpAbzs1JENx6Z66ms8wBiQkdk7sK7Z8sEi6k+4L/ogSYjdQWbz?=
 =?us-ascii?Q?dDFz23ztYtWSvkerx3VZQLAhCTWihWjegdDVYo6cXSZHnbZNkqQBZ14TIkaH?=
 =?us-ascii?Q?5CI53+w1ySmBL+MLVcOhhjff1gjyRGvkG2MxDfcq468g+7EJLfBBkJZEY3i2?=
 =?us-ascii?Q?+I41IT+fn0OC9DAkgwtEmEA2gijr0p4+HUXrI49dpu46sp/u5EaCJCUfiwTA?=
 =?us-ascii?Q?zBeVsIZh82CQ2QIBEdmjeEw41r1+NTsR0fDU/d9ClT3gSK1tKKDGwVswl9Ls?=
 =?us-ascii?Q?rrTkETDyhg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f23315a-38ff-446d-dcf2-08de5837c3c9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:22:46.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM8t+KncR+kVgpD+4wjpPyVDfJmX+0Zujuw179fTvzYmv7LFNzC7aE8/u6m8O1mz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2098-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lorenzo.stoakes@oracle.com,m:akpm@linux-foundation.org,m:jarkko@kernel.org,m:dave.hansen@linux.intel.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:jani.nikula@linux.intel.com,m:joonas.lahtinen@linux.intel.com,m:rodrigo.vivi@intel.com,m:tursulin@ursulin.net,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:matthew.brost@intel.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:bcrl@kvack.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kern
 el.org,m:almaz.alexandrovich@paragon-software.com,m:hubcap@omnibond.com,m:martin@omnibond.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:cem@kernel.org,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:ziy@nvidia.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:jannh@google.com,m:pfalcato@suse.de,m:dhowells@redhat.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux-sgx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:intel-gfx@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-aio@kvack.org,m:linux-ero
 fs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-mm@kvack.org,m:ntfs3@lists.linux.dev,m:devel@lists.orangefs.org,m:linux-xfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:linux-security-module@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[93];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BDF5E46325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 03:10:54PM +0000, Lorenzo Stoakes wrote:
> The natural implication of what you're saying is that we can no longer use this
> from _anywhere_ because - hey - passing this by value is bad so now _everything_
> has to be re-written as:

No, I'm not saying that, I'm saying this specific case where you are
making an accessor to reach an unknown value located on the heap
should be using a pointer as both a matter of style and to simplify
life for the compiler.

> 	vma_flags_t flags_to_set = mk_vma_flags(<flags>);
> 
> 	if (vma_flags_test(&flags, &flags_to_set)) { ... }

This is quite a different situation, it is a known const at compile
time value located on the stack.

> If it was just changing this one function I'd still object as it makes it differ
> from _every other test predicate_ using vma_flags_t but maybe to humour you I'd
> change it, but surely by this argument you're essentially objecting to the whole
> series?

I only think that if you are taking a heap input that is not of known
value you should continue to pass by pointer as is generally expected
in the C style we use.

And it isn't saying anything about the overall technique in the
series, just a minor note about style.

> I am not sure about this 'idiomatic kernel style' thing either, it feels rather
> conjured. Yes you wouldn't ordinarily pass something larger than a register size
> by-value, but here the intent is for it to be inlined anyway right?

Well, exactly, we don't normally pass things larger than an interger
by value, that isn't the style, so I don't think it is such a great
thing to introduce here kind of unnecessarily.

The troubles I recently had were linked to odd things like gcov and
very old still supported versions of gcc. Also I saw a power compiler
make a very strange choice to not inline something that evaluated to a
constant.

Jason

