Return-Path: <linux-erofs+bounces-928-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA6B38913
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Aug 2025 19:58:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cBshJ34khz3bb2;
	Thu, 28 Aug 2025 03:58:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2417::621" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756317488;
	cv=pass; b=IZBGzVrYBaswKVVyJeLt93M8OHJ4uUe+x3xmKFwkSPtFdfKy7YrADBdzc4um/lkC9bV88MypVt1WnY/lg+J01WK4BKlpBHWcDfLmjZZrJYOIW4m3AsGu/hkFnK+tQZ72/yCV1P4PMj23D3Te4GKLBu8MnvjbIO9UPw3mJ6KW9ySyY6fdbwPCIk6D1PHKZoRI01S3q3Jt4E35MYVfvPLH1R38KG0CUKZfD7+/g5OyM1dLmaZ1ALBMJKnLVj4uWvly7zGnCKxG4pM3dU2hxPPdepIa64+WpeJJLFtHrmE/CuED/N5ym4Mzd/5hpOOHFOEBFXfp3BWgEw5kW4U9A7i6jA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756317488; c=relaxed/relaxed;
	bh=c7P8rS/FN7tYHE5zC07t5Nohp3J7vjlgyJvv+rX2yD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfesAHyzjAPaR51M0YkhgqyC3AJ9ql7qz70DU36vSNeHFrYh3xXqnNzJ7OUqtsGe5508JKGMsUnoRZNJ2p8zOxjn46nV6eLiXoc6ja5RDMJ1IA3nFahWS+SWAxjraVLTnBVr5OpekWRrtkdtkKAl4OR/AKI4PHkrJYqXCA5SUHd4tLApTBoaWmtN19Fmy7sp1lZkCinNeWwqiTF5IdWaMVIa+PrbkPhK8BtdSvt0WgERr8+m48Nst+i6bURKTiecXBWSWLWIaRs/HFhIbZOhLlDt3nv5X6BCdakPCyBmj2o24wBc7iK5hrXhvO0f39erVU1Ya84hkb3XVOBeFNdrOQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EPdAfT6V; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2417::621; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=shivankg@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EPdAfT6V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:2417::621; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=shivankg@amd.com; receiver=lists.ozlabs.org)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20621.outbound.protection.outlook.com [IPv6:2a01:111:f403:2417::621])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cBshH4qSNz30WF
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Aug 2025 03:58:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k689SCoUbpPzIpZRJ5wePmfPtGqMgYEO2nqLoCEX/L8aj4mYsiNznsjvB2e6hoWQdeFQJ74RH++wJ/XhX20zsg/FD2Arj0UoQjcPptmIDhWwhuX0WBxetoXYSA5UvRPQIKsfZaTo/YGywsD6PnCsTt+BiODXZCnEeWtYEWkyjnDSFy6c35BjmUTx3HEBNXEs4oxWRV4CzMywzofKCl6jY9xIJUsG/U9S71gW0SzK7KkbaBumjpKQrYPcqYu4iPYulYwgACpY0+MCMPpQvaoylv1wvywooqld3JjMOxomT7KaPB0lGiy5FJSg7wDvSo8h0MtQuBtRNrvUFbbT8ysUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7P8rS/FN7tYHE5zC07t5Nohp3J7vjlgyJvv+rX2yD4=;
 b=iJsjFHg33gsfIH2devlm06AV+ll3M4DR7//BEevrDS0/YG+ptIGkfX4+tB4x8MvtZgFuTsmTAiYXe1eMP2Afrts4NRttk535pn5ad1LWnsj9SXDzybAr9P+RYH0wBO/7CQ6GI4Nj+9BMeJeIZ4Ez+QJ1mmGB64ZAwaxQ+aH2399Jx11YTQMlO0Xss7YjFO6cyZo+GX7WtGCQaRPbUtReCZ03qEHTjyA3XjD8iFFqxsgkL3NMwrK4x6HvEhUnFKUcrzbiDfiS5YBpRRrs2XaoyoS8AHtdFbDOTk8j8OFeLKJGWpBg0nS0WYPdKwWTSLhhRLhRBZcyNccg2G//FuI6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7P8rS/FN7tYHE5zC07t5Nohp3J7vjlgyJvv+rX2yD4=;
 b=EPdAfT6Vam34gw45FYIQbCxvaXOdqzpBK4CJkUBceL2onRdqF9NAlGjJaO5AWkMoqz2vxWm+r03lhGegmmGFUSAbEJl/sRLHCPHGO72mtaAFLy2tKjHf9HbXeY1FLVnZBYTZ6opu3IQD1ZNv9wiG0NnvCn97ABvmA1z6DS20pXA=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 17:57:48 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::28) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Wed,
 27 Aug 2025 17:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 17:57:47 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 12:57:28 -0500
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
Subject: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy support
Date: Wed, 27 Aug 2025 17:52:49 +0000
Message-ID: <20250827175247.83322-10-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c57367-5670-4b97-8940-08dde5933b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1UaZtivtjyZ5kE/DAGrUBSUaJ9cWi4e6Na1KN1Sz4JLOG4i1GNQqEX41fF+?=
 =?us-ascii?Q?v1WoZn6FfKAI1Rzmtq0O39ADdQfjjhkhnFe8fCwDGaZzS8dgFO+eLjfKZGBP?=
 =?us-ascii?Q?nMBh3mgVYQcbisQB4ZDH2m2aJQOIUch7LNxCb4qxPeFmtspovltZslnv3B0T?=
 =?us-ascii?Q?DYhYvKzVpfbRUApB32wgsAV7uRo2TIk8ItmfI6zwomx7kfRcqVs9fSB+gBCr?=
 =?us-ascii?Q?PDSys4BXiVApMOpFijKE8f2sIaHA/R34bjmUJXVyCeu3Dol/4Z3shBu6Tdj3?=
 =?us-ascii?Q?hvgmEkKYkx8EnLf6zs2KOQB3RUrx1k25a0TSBpXS2UEaoYYrbaoIpeeZ0SHG?=
 =?us-ascii?Q?8xYc3/+g+CdjYSka8pWZhYgH/qEd34tbXMPpauMfzsFD8K7GZmV5XNf/VjBW?=
 =?us-ascii?Q?Pt2SeELhh0c7J9o+x/IEmLJBTLvOO8FWnNzdvex6KmPK6zbFr3COLi1IIyBF?=
 =?us-ascii?Q?tboZ26M6+Hb3TgPRuLM3pOu2Lo2FVi/1SQIEoOi4DgyFBe69zBUpGkIuUctw?=
 =?us-ascii?Q?vQ0tFdJXe+vzMcn1tpLiAMCuBLtp44RclYXI8yet+cBdyEnDwjfIkjsZMnZO?=
 =?us-ascii?Q?Wer+RG8e6/G/GQwwcH2kuRf5m65pyywDXLr3+OKQLM+a9BsWKWfEdQm4W0Dg?=
 =?us-ascii?Q?AehsShni0OUihzGe44wWchFqSJVae5ssY6vudRa1Chug1IVRTICZIME+SK6L?=
 =?us-ascii?Q?nyXx3SpqS9kjc7dfE+Umlw2NTM4OzXXVopcxHJCPijQ3bp/lJbTgKlSl7cbM?=
 =?us-ascii?Q?4tJnoRNuB5dNhfzYYm+w0KH+yvbICTvCmIa8dTTEUCs4ATHHWh0V0JBNtzcb?=
 =?us-ascii?Q?G3cjrWkaNGeoQZKlj5T96aGAg2xM/MNEQNM7V08Ao6BWXt6NEZOj5os91eU+?=
 =?us-ascii?Q?lB/tLJmJGfjHOheknMETAL28poRglc9JLnFZ3B1YRKMgZggn9dvkOqA/Ds96?=
 =?us-ascii?Q?dImvSxXYuyxpGDmxeSAnmDOFpJutoPMC0GyHcjEu9AUQXUW9d08os3vtyY0m?=
 =?us-ascii?Q?1QHdHqiRC4JkwibmTXD7ZiXdyHkyK9k/yMexkiwCT+DRggFaL/qLDJR0JosC?=
 =?us-ascii?Q?h8V4ukQL/31Hz1yupdSvQRsPAG+Yu6SAEFTI/CkWv2kgEoCyx2TvDLJjIevT?=
 =?us-ascii?Q?0GPO9URH+6sYGy/BaUF5vQ3U/PdPbwlTIlGZkylETFxsg8syvZU7HaaubJRv?=
 =?us-ascii?Q?oGE3tXo5q5P4N0a+dRH2S3kxIy2E0FB3uAQ+EdqDug6jyOQG4+Kd+UU8rSkB?=
 =?us-ascii?Q?q1O5+VO3aipjC7X2QHrDD9jFcxfSLg8i6+5Glm64FK7bEUBeOQEoMbCTW+N8?=
 =?us-ascii?Q?XESYdhvjbmfbOEgqm/ULUd+/I94fkVjGJUx7DzLcJgWh/Z4eErhKg+zAkpdk?=
 =?us-ascii?Q?nRqqug132HEEPUOEsJVQiGp0msPnXjeHlO0wrmdqMHHSzeqVrYXurnhdcgcU?=
 =?us-ascii?Q?ejIBAkhFm9eX2oiST6ptBZ3PzMLbZIwunfonqEScgu7UCH68LYBu8lN7rs2X?=
 =?us-ascii?Q?Nb40rUuWHHK4ClsGoBMApHyTPVDrKlppCosS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 17:57:47.5904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c57367-5670-4b97-8940-08dde5933b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add tests for NUMA memory policy binding and NUMA aware allocation in
guest_memfd. This extends the existing selftests by adding proper
validation for:
- KVM GMEM set_policy and get_policy() vm_ops functionality using
  mbind() and get_mempolicy()
- NUMA policy application before and after memory allocation

These tests help ensure NUMA support for guest_memfd works correctly.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 90f03f00cb04..c46cef2a7cd7 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -275,6 +275,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
 
 LDLIBS += -ldl
+LDLIBS += -lnuma
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
 LIBKVM_C := $(filter %.c,$(LIBKVM))
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index b3ca6737f304..9640d04ec293 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -7,6 +7,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <numa.h>
+#include <numaif.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -19,6 +21,7 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 
 #include "kvm_util.h"
 #include "test_util.h"
@@ -72,6 +75,122 @@ static void test_mmap_supported(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "munmap() should succeed.");
 }
 
+#define TEST_REQUIRE_NUMA_MULTIPLE_NODES()	\
+	TEST_REQUIRE(numa_available() != -1 && numa_max_node() >= 1)
+
+static void test_mbind(int fd, size_t page_size, size_t total_size)
+{
+	unsigned long nodemask = 1; /* nid: 0 */
+	unsigned long maxnode = 8;
+	unsigned long get_nodemask;
+	int get_policy;
+	char *mem;
+	int ret;
+
+	TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap for mbind test should succeed");
+
+	/* Test MPOL_INTERLEAVE policy */
+	ret = syscall(__NR_mbind, mem, page_size * 2, MPOL_INTERLEAVE,
+		      &nodemask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind with INTERLEAVE to node 0 should succeed");
+	ret = syscall(__NR_get_mempolicy, &get_policy, &get_nodemask,
+		      maxnode, mem, MPOL_F_ADDR);
+	TEST_ASSERT(!ret && get_policy == MPOL_INTERLEAVE && get_nodemask == nodemask,
+		    "Policy should be MPOL_INTERLEAVE and nodes match");
+
+	/* Test basic MPOL_BIND policy */
+	ret = syscall(__NR_mbind, mem + page_size * 2, page_size * 2, MPOL_BIND,
+		      &nodemask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind with MPOL_BIND to node 0 should succeed");
+	ret = syscall(__NR_get_mempolicy, &get_policy, &get_nodemask,
+		      maxnode, mem + page_size * 2, MPOL_F_ADDR);
+	TEST_ASSERT(!ret && get_policy == MPOL_BIND && get_nodemask == nodemask,
+		    "Policy should be MPOL_BIND and nodes match");
+
+	/* Test MPOL_DEFAULT policy */
+	ret = syscall(__NR_mbind, mem, total_size, MPOL_DEFAULT, NULL, 0, 0);
+	TEST_ASSERT(!ret, "mbind with MPOL_DEFAULT should succeed");
+	ret = syscall(__NR_get_mempolicy, &get_policy, &get_nodemask,
+		      maxnode, mem, MPOL_F_ADDR);
+	TEST_ASSERT(!ret && get_policy == MPOL_DEFAULT && get_nodemask == 0,
+		    "Policy should be MPOL_DEFAULT and nodes zero");
+
+	/* Test with invalid policy */
+	ret = syscall(__NR_mbind, mem, page_size, 999, &nodemask, maxnode, 0);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "mbind with invalid policy should fail with EINVAL");
+
+	TEST_ASSERT(munmap(mem, total_size) == 0, "munmap should succeed");
+}
+
+static void test_numa_allocation(int fd, size_t page_size, size_t total_size)
+{
+	unsigned long node0_mask = 1;  /* Node 0 */
+	unsigned long node1_mask = 2;  /* Node 1 */
+	unsigned long maxnode = 8;
+	void *pages[4];
+	int status[4];
+	char *mem;
+	int ret, i;
+
+	TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+
+	/* Clean slate: deallocate all file space, if any */
+	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap should succeed");
+
+	for (i = 0; i < 4; i++)
+		pages[i] = (char *)mem + page_size * i;
+
+	/* Set NUMA policy after allocation */
+	memset(mem, 0xaa, page_size);
+	ret = syscall(__NR_mbind, pages[0], page_size, MPOL_BIND, &node0_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind after allocation page 0 to node 0 should succeed");
+	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	/* Set NUMA policy before allocation */
+	ret = syscall(__NR_mbind, pages[0], page_size * 2, MPOL_BIND, &node1_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind page 0, 1 to node 1 should succeed");
+	ret = syscall(__NR_mbind, pages[2], page_size * 2, MPOL_BIND, &node0_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind page 2, 3 to node 0 should succeed");
+	memset(mem, 0xaa, total_size);
+
+	/* Validate if pages are allocated on specified NUMA nodes */
+	ret = syscall(__NR_move_pages, 0, 4, pages, NULL, status, 0);
+	TEST_ASSERT(ret >= 0, "move_pages should succeed for status check");
+	TEST_ASSERT(status[0] == 1, "Page 0 should be allocated on node 1");
+	TEST_ASSERT(status[1] == 1, "Page 1 should be allocated on node 1");
+	TEST_ASSERT(status[2] == 0, "Page 2 should be allocated on node 0");
+	TEST_ASSERT(status[3] == 0, "Page 3 should be allocated on node 0");
+
+	/* Punch hole for all pages */
+	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	/* Change NUMA policy nodes and reallocate */
+	ret = syscall(__NR_mbind, pages[0], page_size * 2, MPOL_BIND, &node0_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind page 0, 1 to node 0 should succeed");
+	ret = syscall(__NR_mbind, pages[2], page_size * 2, MPOL_BIND, &node1_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind page 2, 3 to node 1 should succeed");
+	memset(mem, 0xaa, total_size);
+
+	ret = syscall(__NR_move_pages, 0, 4, pages, NULL, status, 0);
+	TEST_ASSERT(ret >= 0, "move_pages should succeed after reallocation");
+	TEST_ASSERT(status[0] == 0, "Page 0 should be allocated on node 0");
+	TEST_ASSERT(status[1] == 0, "Page 1 should be allocated on node 0");
+	TEST_ASSERT(status[2] == 1, "Page 2 should be allocated on node 1");
+	TEST_ASSERT(status[3] == 1, "Page 3 should be allocated on node 1");
+
+	TEST_ASSERT(munmap(mem, total_size) == 0, "munmap should succeed");
+}
+
 static sigjmp_buf jmpbuf;
 void fault_sigbus_handler(int signum)
 {
@@ -286,6 +405,8 @@ static void test_guest_memfd(unsigned long vm_type)
 	if (flags & GUEST_MEMFD_FLAG_MMAP) {
 		test_mmap_supported(fd, page_size, total_size);
 		test_fault_overflow(fd, page_size, total_size);
+		test_mbind(fd, page_size, total_size);
+		test_numa_allocation(fd, page_size, total_size);
 	} else {
 		test_mmap_not_supported(fd, page_size, total_size);
 	}
-- 
2.43.0


