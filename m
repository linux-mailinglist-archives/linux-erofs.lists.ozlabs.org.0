Return-Path: <linux-erofs+bounces-926-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D8566B3890A
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Aug 2025 19:57:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cBsgb5Qmsz30Ff;
	Thu, 28 Aug 2025 03:57:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2412::630" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756317451;
	cv=pass; b=gGjrRbct7zhbX+ashoIETxydBza/lpmAehpg+PMgTAM4RfS73MwJFU0CSBm4icB0YOHDP37eFCUHfJKDF689D7kjBVJSEepbsnBsQilKyxqLILMwhX9r84qOO8nJxnkHJB/mQE1iJpAjDbnKRs9AlWYes0fbCDYHM7OZ+Zo8siHU91K5yPQeWkJjTCqT505GMd4wFQUNiJoaz/jB0WOF2sIPQztH/h7lnmztFMaGbOp3wrnn3oF0VCQibJ3/BjDI3fg6HK15ajsldJ402xzCW/toEvdv0ng89os1lPDM5SYZD40vSsouCNPHgsRMokUhrUGW0VKq9kOLu3sl1jt5Mw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756317451; c=relaxed/relaxed;
	bh=Mh45BlQRd8lKAcWzWmeHjSQU39/827vrG2yxSJSUH2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUsONI5NwsKaT9ujgX33OXnEmWNqtYNl+7NuwocfWn6AXhYnXEF16Y8Xh5fDtUaX+zkqKyPfO87V9JvcA4ywaOBgwS0ZroMcEfV0ooAPMOF9/GSvP+ylmQ5GaxEOIDaqMd37cw4346VJCCLso6vGKejX8d0P1P5yHz1tcZEDsWdvAG56JFvSjgxC9jrUnMlkulRP35DuoVrIfl40M1m4uS3a/4VMlHeTiwbYeJeKQt8Tw6gGMCS8Q6HsuV7lP7P46HkFR/RGu19xexLcwVmj4jL7l0/9SSOKEf9HQbeYAyWfk/RHDcJ3uXyz+kA4Wwbng/dMSiVFVmump7GpElK+Qw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=saqCQBEK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2412::630; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=shivankg@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=saqCQBEK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:2412::630; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=shivankg@amd.com; receiver=lists.ozlabs.org)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20630.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cBsgZ6f0tz2yDH
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Aug 2025 03:57:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Crbxdl7vQNLQxLfHFuTNfAYDotXG4cZausWBd2QQ12uhsZkpSPC0Olnn6ln6p1BtwIcSsqQBpvYVIl041iZNoWI8NP6vdfwNaSKBCngNYxHvr3WmtL5lbsFgjE38Sq8OTuuOyRnkejKPFumQERjVzYkk19Iwn+hcgBzlHLHjKoK7v8t4FVuyE0W+A22tbrwUOvNla9cxy34O+PmAU6oD2kXACB9B/ZdJbL0XiIcNJZLCAA+4AAoDvtmaB1sffnq/mcl6Qu3WHnELrXvhzidkIU5yGfmAHqsY7T3xDPn6jQdM70rHoXz9Qz11ViXOYB8dLJcijU8tY0wh1tn8WrpmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh45BlQRd8lKAcWzWmeHjSQU39/827vrG2yxSJSUH2s=;
 b=XxAwEoG34XHdDgaZ7XhQHRf/JblZjgxVDV8T0eTY4P5NvOy4+LQYaNf0S18f8mIRhPbISTPhs8K02yPCBsZ9TKOzxk/nwyrO1DSe43H/b4Yr1b7ooFwSGmcVlBop35z6B+Fj+nNlctU/0VZsJDeWmKXfLaKzjb+pYa6lJwVzlACwFgH0ePXfwMB2s3OvLr/2be+ilGnhQLOa0Sq30UDdAeDhWI9DY6MBJjkv/eCbXzhWgcRN4DhFizWFl/7THXJ79vG7fpM87QXdSwP1+q40THciv+t485x3mjglmDQxvIJAGZlIwmAw80jWUiLNWs+LKoqeqagz7vA4H0vm8K78pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh45BlQRd8lKAcWzWmeHjSQU39/827vrG2yxSJSUH2s=;
 b=saqCQBEKniu2NdXJ0fKOFA32ETu+Ouz/ptHQgvAj9A6g2SvdgGJeUHYj6NTyOmx0O4G/4lHrGA0jhYQCi7i/2R+4hKq4az0EFlXiFT1tYWQfj1ae6tbDYx/aATKbnVpLelPV+yYbkQrXJdTjh+7CsnI/vBm6jzAvAnSDO6xX66A=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 17:57:11 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e0) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.6 via Frontend Transport; Wed,
 27 Aug 2025 17:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 17:57:11 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 12:56:50 -0500
From: Shivank Garg <shivankg@amd.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <seanjc@google.com>,
	<vbabka@suse.cz>
CC: <brauner@kernel.org>, <viro@zeniv.linux.org.uk>, <dsterba@suse.com>,
	<xiang@kernel.org>, <chao@kernel.org>, <jaegeuk@kernel.org>, <clm@fb.com>,
	<josef@toxicpanda.com>, <kent.overstreet@linux.dev>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <lihongbo22@huawei.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<apopple@nvidia.com>, <tabba@google.com>, <ackerleytng@google.com>,
	<shivankg@amd.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<vannapurve@google.com>, <chao.gao@intel.com>, <bharata@amd.com>,
	<nikunj@amd.com>, <michael.day@amd.com>, <shdhiman@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <chao.p.peng@intel.com>,
	<amit@infradead.org>, <ddutile@redhat.com>, <dan.j.williams@intel.com>,
	<ashish.kalra@amd.com>, <gshan@redhat.com>, <jgowans@amazon.com>,
	<pankaj.gupta@amd.com>, <papaluri@amd.com>, <yuzhao@google.com>,
	<suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<linux-bcachefs@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH kvm-next V11 5/7] KVM: guest_memfd: Add slab-allocated inode cache
Date: Wed, 27 Aug 2025 17:52:47 +0000
Message-ID: <20250827175247.83322-8-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
References: <20250827175247.83322-2-shivankg@amd.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: df7a1307-3632-461b-0cd8-08dde59325fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrCqZiqASNJkr8Bzps5Md5zNXQTaaQPHmuCU5wucKi7dGsruYQeAD5qsMHUv?=
 =?us-ascii?Q?roDslivbOLCdj2GVZnKw2s1MkXKf3Fw4k7iKNNZUettCfVFr4vZcmwfD2Bb8?=
 =?us-ascii?Q?XYFkwo3Jiw8YFfr0VElE8pntEtoANb8CHcO38Iwvmmb3iCFNP0HPi+s4ZoLo?=
 =?us-ascii?Q?L52T+wJ7nKZ6onP1ad+WD6b/7zFCreWepCAVlYAxioAPcTqpSnWUoo7iWbTo?=
 =?us-ascii?Q?TNMIHUWLFCYfo5BifYKe3bQB8de+b226750KwgFrcumeM4vJSKUd4wqZA/t0?=
 =?us-ascii?Q?0eRDzH89kiBiUOfx6Vca4eeCz+K5CdnmPfpkYThBY1KJB97g9/NvW9Utbixo?=
 =?us-ascii?Q?3fSLsZECxYspI0hJf5WiBgh3qyfTVaKwf41z7EBcgMsBSW4PIyUQOqDN6JO1?=
 =?us-ascii?Q?EgDPKXvRp0WuLXbF9gNv2Cyog+NuiYcYEvAEylSQXqpSZyN3F4wp8TAdX3sA?=
 =?us-ascii?Q?IpdB1S67xW1w/gmO0I036w+dI5JnWHssgyPBDWlX8ib3jz1wcxHWmBBBJArP?=
 =?us-ascii?Q?EobxRz0FxaRfZ2z4ioPkLwuVRyAceBTT9rHCYLc0PN6g57L4T982WJnULy04?=
 =?us-ascii?Q?lpmnXJq31FKkOTGyKqJWy31Pu+4kGtsfvrj7NsVrB53qaUJbTU2cq4iegbXy?=
 =?us-ascii?Q?iqkyQYonJ9jQaqPJHKwBgqyaevt6+V04jkCtvNDeH863NjFVC39OLzrMNJ0A?=
 =?us-ascii?Q?X06t7tqTBiLm69WEMzat559QoFgQKHkxQvIh8txi9JhNaZN8e+ihFreMHsm5?=
 =?us-ascii?Q?mALpbGVAYN1TmvYAYxwGgkc9yEXnEGK1s1Cp8Y/3u9nBmnwiSjWfzjjOF0hK?=
 =?us-ascii?Q?QmsjJrz9hlienBq1lyqEJ30IdzRX0K6u8KyXhl7r0QR59DMHPnwfxB8Mf+vJ?=
 =?us-ascii?Q?0PH09DxFzuyKvnT1kNurWVJ2u0ncW9prm6//kHwIWHbixkWs9EpdA/h4yh15?=
 =?us-ascii?Q?PR1JZ/cJr+3lIgxMpNiYoOEvgn+nuwrcuBSf8KeAfzYYEV4Xo3oJoKszMSzX?=
 =?us-ascii?Q?8r24y3WETpnsmLvjYPvMubBpGVapx/p66x2N5bR7a4FiTPb0CEqVswcdQuYx?=
 =?us-ascii?Q?yAnmiYavvw2dW36vALopCn3mIQD/s7QByX0616/DyBlyX+zUlncrOt/BS2mY?=
 =?us-ascii?Q?XTMsR8kA7MXyzPgIOOSQhbI1CLrVxD7AvDb28K9EiFQOQt16iD3mB89yRK9p?=
 =?us-ascii?Q?f++p3y47uoftQDKar/+NV8u0wNxmIcXpY4r6s5iVhiVuEQf1ktAlH9208w5f?=
 =?us-ascii?Q?U8ciDte7GN6vMoKEbtNs3CLc+yKUqLjGr7Ih1FJciWZAs/EMYYhUXByYG2my?=
 =?us-ascii?Q?qOUUGBlEpnngqUZ+0mGbZtJvbsjd3iA92cSUeaHgc6sTjF9YIoln+s+/282Q?=
 =?us-ascii?Q?zUu7ig8yJgKNokmcbGnkOJqtuKkesJJYarkPtundAHwe/ie/OhPq6jqhOvFx?=
 =?us-ascii?Q?2GVScC5n+G+X6Spa35WzO/iZsDD5F1Qn+4RM9iKIzbAkECTba4+bl9+bGwfU?=
 =?us-ascii?Q?T/INWH/efkKV3Whtvplue8hv6FTO0UG9PB+C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 17:57:11.5234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7a1307-3632-461b-0cd8-08dde59325fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
inode cache for guest memory backing, similar to how shmem handles inodes.

This adds the necessary allocation/destruction functions and prepares
for upcoming guest_memfd NUMA policy support changes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 70 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 6c66a0974055..356947d36a47 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -17,6 +17,15 @@ struct kvm_gmem {
 	struct list_head entry;
 };
 
+struct kvm_gmem_inode_info {
+	struct inode vfs_inode;
+};
+
+static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
+{
+	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -389,13 +398,46 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };
 
+static struct kmem_cache *kvm_gmem_inode_cachep;
+
+static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
+{
+	struct kvm_gmem_inode_info *info;
+
+	info = alloc_inode_sb(sb, kvm_gmem_inode_cachep, GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	return &info->vfs_inode;
+}
+
+static void kvm_gmem_destroy_inode(struct inode *inode)
+{
+}
+
+static void kvm_gmem_free_inode(struct inode *inode)
+{
+	kmem_cache_free(kvm_gmem_inode_cachep, KVM_GMEM_I(inode));
+}
+
+static const struct super_operations kvm_gmem_super_operations = {
+	.statfs		= simple_statfs,
+	.alloc_inode	= kvm_gmem_alloc_inode,
+	.destroy_inode	= kvm_gmem_destroy_inode,
+	.free_inode	= kvm_gmem_free_inode,
+};
+
 static int kvm_gmem_init_fs_context(struct fs_context *fc)
 {
+	struct pseudo_fs_context *ctx;
+
 	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
 		return -ENOMEM;
 
 	fc->s_iflags |= SB_I_NOEXEC;
 	fc->s_iflags |= SB_I_NODEV;
+	ctx = fc->fs_private;
+	ctx->ops = &kvm_gmem_super_operations;
 
 	return 0;
 }
@@ -417,17 +459,41 @@ static int kvm_gmem_init_mount(void)
 	return 0;
 }
 
+static void kvm_gmem_init_inode(void *foo)
+{
+	struct kvm_gmem_inode_info *info = foo;
+
+	inode_init_once(&info->vfs_inode);
+}
+
 int kvm_gmem_init(struct module *module)
 {
-	kvm_gmem_fops.owner = module;
+	int ret;
+	struct kmem_cache_args args = {
+		.align = 0,
+		.ctor = kvm_gmem_init_inode,
+	};
 
-	return kvm_gmem_init_mount();
+	kvm_gmem_fops.owner = module;
+	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
+						  sizeof(struct kvm_gmem_inode_info),
+						  &args, SLAB_ACCOUNT);
+	if (!kvm_gmem_inode_cachep)
+		return -ENOMEM;
+	ret = kvm_gmem_init_mount();
+	if (ret) {
+		kmem_cache_destroy(kvm_gmem_inode_cachep);
+		return ret;
+	}
+	return 0;
 }
 
 void kvm_gmem_exit(void)
 {
 	kern_unmount(kvm_gmem_mnt);
 	kvm_gmem_mnt = NULL;
+	rcu_barrier();
+	kmem_cache_destroy(kvm_gmem_inode_cachep);
 }
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
-- 
2.43.0


