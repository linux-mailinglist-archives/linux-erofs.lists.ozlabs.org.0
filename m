Return-Path: <linux-erofs+bounces-2246-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDFrCUY2fWkwQwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2246-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jan 2026 23:52:54 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F25BF3A8
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jan 2026 23:52:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2rrG3mfrz2y7b;
	Sat, 31 Jan 2026 09:52:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769813566;
	cv=none; b=MMxVJoN4dsEJMZRbZ+c1EtH80v77zc3h2isN7kpi2lG3NYRNj+AKlf7dJdgJjxp1F+x56lUQ27ZDkvxXCBxJ1gTbgPNZMTBZQhf8bGZ5utNwgKydrJjRFfcmN2sJhDVc5KYnbwdO0ZrWPJodCg7G0MwTTaBBKAqccl4QjvqfinqlfzZbJ3BTLOeYHV6rkegqsRjavDy1f99LlTl2txIEK1FaUMx0VUlApzxEiTmd0OjDBLW3vtvhvZPzFshh0mu9IK1Td455l9Rf6qsQWbERKv0eCnqECwR/39o9C+mzx+33c8BNlkYu6SHJUlYiHzfnWe09IihxB6lThylsCRp+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769813566; c=relaxed/relaxed;
	bh=2SSTTP5iypxQoN/O7fYiaGfenDqS98kgrXvGQI3Lm3Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M0e108U3TMINhyv9QleATHkxKJ5uh5i0FW0s7f2nwdnP55roK+ceg74EORjy6VGk55Y/hsGkDhDMGJs1vmMMnEmQdIaJzRDhPkdq/JFGevCUW0OZdEs58VunLD0g3Yqf2ZS+Cl6//9XB64W/myDRBZNpx04dtdHf8fV4mibYsC6HrvPDdQjGHGkWCk4Xf6u51GNqSPC1bpUIKIGGsdekBNCfrCbFFeB+KQwN9WUG0sv65nE/JPl5wSjh32exqQcMuXSMPvx8mDmLkzUxtl2uV+WgHjTF945KQv/c86Wlg/pD3K25mTc2q6s7vrUVNFrndtQtuwLrl7L5nbBpfj8iiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mL4zdUaU; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mL4zdUaU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2rrC2W94z2xnj
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Jan 2026 09:52:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769813564; x=1801349564;
  h=date:from:to:cc:subject:message-id;
  bh=5yrrSpUM5UMP7Umug7Cq9Q0JNAzgpcE//SAX7Xn4v6g=;
  b=mL4zdUaUJTI/V81XyJ1w24RuQocmubKByVeVBLps904nRXp4yc776OPO
   lGMte42b73d9A7rFS553CEpucqNK1+vvF3YFNKIRWr1NS1SPWvbxQDa7x
   2jwSp1Nkor7Rs6A6Sbrm27JrgRfy5u3zVcTcWvovn7Yk/cfceUIYaGq9j
   SOTqxV7CORW14VYxXLbD2rQLeynKeI0Yq3r8FdzQRFh7FbHZDpLDFlDjr
   KaJSuy4QA3TyhH4mjx4779Pi1TuDbwMwP99XiWJRmcRFuPZgcbR7LwI0x
   0AUBEi6Qu3zWHp/1AtHHFttsJsvuStM/KAbcIS90s3SCj5kHMhd5bc38S
   w==;
X-CSE-ConnectionGUID: GWPC9LgkS0upu5kCSvdrkA==
X-CSE-MsgGUID: 4zHmfGY3Rle9NI+F5Cq9pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="88485244"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="88485244"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 14:52:38 -0800
X-CSE-ConnectionGUID: 9DUf5APESmyOj/jyD3UVcQ==
X-CSE-MsgGUID: naA4Z7vGQ4SJc/Uzo/owlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="213902896"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Jan 2026 14:52:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlxLt-00000000dSe-364p;
	Fri, 30 Jan 2026 22:52:33 +0000
Date: Sat, 31 Jan 2026 06:52:24 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 886176025101af8775089b64dd1b324bb66cbcd2
Message-ID: <202601310619.iIgXqS2U-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2246-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 67F25BF3A8
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 886176025101af8775089b64dd1b324bb66cbcd2  erofs: handle end of filesystem properly for file-backed mounts

elapsed time: 867m

configs tested: 269
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    clang-22
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260130    clang-17
arc                   randconfig-001-20260131    gcc-8.5.0
arc                   randconfig-002-20260130    clang-17
arc                   randconfig-002-20260131    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                          pxa910_defconfig    clang-22
arm                   randconfig-001-20260130    clang-17
arm                   randconfig-001-20260131    gcc-8.5.0
arm                   randconfig-002-20260130    clang-17
arm                   randconfig-002-20260131    gcc-8.5.0
arm                   randconfig-003-20260130    clang-17
arm                   randconfig-003-20260131    gcc-8.5.0
arm                   randconfig-004-20260130    clang-17
arm                   randconfig-004-20260131    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260130    gcc-8.5.0
arm64                 randconfig-001-20260131    clang-22
arm64                 randconfig-002-20260130    gcc-8.5.0
arm64                 randconfig-002-20260131    clang-22
arm64                 randconfig-003-20260130    gcc-8.5.0
arm64                 randconfig-003-20260131    clang-22
arm64                 randconfig-004-20260130    gcc-8.5.0
arm64                 randconfig-004-20260131    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260130    gcc-8.5.0
csky                  randconfig-001-20260131    clang-22
csky                  randconfig-002-20260130    gcc-8.5.0
csky                  randconfig-002-20260131    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260130    gcc-11.5.0
hexagon               randconfig-001-20260131    gcc-11.5.0
hexagon               randconfig-002-20260130    gcc-11.5.0
hexagon               randconfig-002-20260131    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260130    clang-20
i386        buildonly-randconfig-001-20260131    clang-20
i386        buildonly-randconfig-002-20260130    clang-20
i386        buildonly-randconfig-002-20260131    clang-20
i386        buildonly-randconfig-003-20260130    clang-20
i386        buildonly-randconfig-003-20260131    clang-20
i386        buildonly-randconfig-004-20260130    clang-20
i386        buildonly-randconfig-004-20260130    gcc-14
i386        buildonly-randconfig-004-20260131    clang-20
i386        buildonly-randconfig-005-20260130    clang-20
i386        buildonly-randconfig-005-20260131    clang-20
i386        buildonly-randconfig-006-20260130    clang-20
i386        buildonly-randconfig-006-20260130    gcc-14
i386        buildonly-randconfig-006-20260131    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260130    gcc-14
i386                  randconfig-002-20260130    gcc-14
i386                  randconfig-003-20260130    gcc-14
i386                  randconfig-004-20260130    gcc-14
i386                  randconfig-005-20260130    gcc-14
i386                  randconfig-006-20260130    gcc-14
i386                  randconfig-007-20260130    gcc-14
i386                  randconfig-011-20260130    clang-20
i386                  randconfig-011-20260131    gcc-14
i386                  randconfig-012-20260130    clang-20
i386                  randconfig-012-20260131    gcc-14
i386                  randconfig-013-20260130    clang-20
i386                  randconfig-013-20260131    gcc-14
i386                  randconfig-014-20260130    clang-20
i386                  randconfig-014-20260131    gcc-14
i386                  randconfig-015-20260130    clang-20
i386                  randconfig-015-20260131    gcc-14
i386                  randconfig-016-20260130    clang-20
i386                  randconfig-016-20260131    gcc-14
i386                  randconfig-017-20260130    clang-20
i386                  randconfig-017-20260131    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260130    gcc-11.5.0
loongarch             randconfig-001-20260131    gcc-11.5.0
loongarch             randconfig-002-20260130    gcc-11.5.0
loongarch             randconfig-002-20260131    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5307c3_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260130    gcc-11.5.0
nios2                 randconfig-001-20260131    gcc-11.5.0
nios2                 randconfig-002-20260130    gcc-11.5.0
nios2                 randconfig-002-20260131    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260130    gcc-8.5.0
parisc                randconfig-001-20260131    gcc-8.5.0
parisc                randconfig-002-20260130    gcc-8.5.0
parisc                randconfig-002-20260131    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      mgcoge_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20260130    gcc-8.5.0
powerpc               randconfig-001-20260131    gcc-8.5.0
powerpc               randconfig-002-20260130    gcc-8.5.0
powerpc               randconfig-002-20260131    gcc-8.5.0
powerpc64             randconfig-001-20260130    gcc-8.5.0
powerpc64             randconfig-001-20260131    gcc-8.5.0
powerpc64             randconfig-002-20260130    gcc-8.5.0
powerpc64             randconfig-002-20260131    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260130    clang-22
riscv                 randconfig-001-20260130    gcc-14.3.0
riscv                 randconfig-001-20260131    gcc-8.5.0
riscv                 randconfig-002-20260130    clang-22
riscv                 randconfig-002-20260131    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260130    clang-22
s390                  randconfig-001-20260131    gcc-8.5.0
s390                  randconfig-002-20260130    clang-22
s390                  randconfig-002-20260131    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260130    clang-22
sh                    randconfig-001-20260130    gcc-9.5.0
sh                    randconfig-001-20260131    gcc-8.5.0
sh                    randconfig-002-20260130    clang-22
sh                    randconfig-002-20260130    gcc-13.4.0
sh                    randconfig-002-20260131    gcc-8.5.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260131    gcc-14
sparc                 randconfig-002-20260131    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260131    gcc-14
sparc64               randconfig-002-20260131    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260131    gcc-14
um                    randconfig-002-20260131    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260130    clang-20
x86_64      buildonly-randconfig-001-20260131    gcc-14
x86_64      buildonly-randconfig-002-20260130    clang-20
x86_64      buildonly-randconfig-002-20260131    gcc-14
x86_64      buildonly-randconfig-003-20260130    clang-20
x86_64      buildonly-randconfig-003-20260131    gcc-14
x86_64      buildonly-randconfig-004-20260130    clang-20
x86_64      buildonly-randconfig-004-20260131    gcc-14
x86_64      buildonly-randconfig-005-20260130    clang-20
x86_64      buildonly-randconfig-005-20260131    gcc-14
x86_64      buildonly-randconfig-006-20260130    clang-20
x86_64      buildonly-randconfig-006-20260131    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260130    clang-20
x86_64                randconfig-002-20260130    clang-20
x86_64                randconfig-003-20260130    clang-20
x86_64                randconfig-004-20260130    clang-20
x86_64                randconfig-005-20260130    clang-20
x86_64                randconfig-006-20260130    clang-20
x86_64                randconfig-011-20260130    clang-20
x86_64                randconfig-011-20260131    clang-20
x86_64                randconfig-012-20260130    clang-20
x86_64                randconfig-012-20260131    clang-20
x86_64                randconfig-013-20260130    clang-20
x86_64                randconfig-013-20260131    clang-20
x86_64                randconfig-014-20260130    clang-20
x86_64                randconfig-014-20260130    gcc-14
x86_64                randconfig-014-20260131    clang-20
x86_64                randconfig-015-20260130    clang-20
x86_64                randconfig-015-20260131    clang-20
x86_64                randconfig-016-20260130    clang-20
x86_64                randconfig-016-20260130    gcc-14
x86_64                randconfig-016-20260131    clang-20
x86_64                randconfig-071-20260130    clang-20
x86_64                randconfig-072-20260130    clang-20
x86_64                randconfig-073-20260130    clang-20
x86_64                randconfig-074-20260130    clang-20
x86_64                randconfig-075-20260130    clang-20
x86_64                randconfig-076-20260130    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260131    gcc-14
xtensa                randconfig-002-20260131    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

