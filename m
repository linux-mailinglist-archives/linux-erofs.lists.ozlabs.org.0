Return-Path: <linux-erofs+bounces-2242-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEL5MaNefGkYMAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2242-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jan 2026 08:32:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D6583B7F1F
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jan 2026 08:32:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2SQm2WbYz3bf4;
	Fri, 30 Jan 2026 18:32:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769758368;
	cv=none; b=VfYB4IZ4hdG4Uu2x7sO52hZxpn/iAeSDY5aBSgaUy2JsRE+ApzkJP9VwiG53lauyW1PcuhaDbeGQwQdxljoLMCn+f+VzW3qLqZUTw8PvjIJ8hnp8MJNdaXbbUj3TbCbtAvhGf9PYyRzSilUydN+Bnhx9Fy6IMfNoZZuvvT3hPIqRVQrhflo1121cx6gW13G3upvN1aLhbHh7awC8B9axQ1bkIX+vt1sfbHBJzsAo1fPLCRUHOme+CD4TFXEkOwXl2qY8FIci5do88CzhU672wgRSzB6M5yTe8bUaDPyqs0ygQ51pvYLi4D17GGBaMU92nScnHLUnfMVjfcBrLT1HMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769758368; c=relaxed/relaxed;
	bh=nqSBhLVkssf04PT8OT5ytP0dkw8cD4oY0BPHf5LDibk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LQ03sorZSRRGa2Uio4ddPaB+LQFYEyu+/zjRhhXxTJATFJk11D19ApK55agbmNtiknqDZy/e8ZEtvjJZW16giKwODCGslTUD8WP7o0kdFrOVzp/GezvO+UpIWEdfU4Xwp0Auc6sedZ+vMKhLUJkIqNguUrY4CfZHbszuq99Y3MrDOtiuRPjU/hvtVO1Ceo6z5W5rGbClFfWmfaJBXe+YVqzqyY+Yim7YASjMALof+Mc+0IlVshN5N7o5MxGznTEJJ7lzqP4K6UkPZHnNhOcOmkS4e42RMb36XorpHNwY71CUF5xN+JPH2g8LoqSkBfVlX0am/NFPknv+nbysCCaNqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QOcvHEmJ; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QOcvHEmJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2SQj48BBz30Pr
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Jan 2026 18:32:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769758366; x=1801294366;
  h=date:from:to:cc:subject:message-id;
  bh=yOOuIlZckf8PqnurQrCoFoPWY0RFH5lr1Q0gpQF0pMA=;
  b=QOcvHEmJcHA1vjMJ2XmXx7VQRAhb9CIVfvAlF5f0k/jeKO3E6JOn5W/8
   jQ/+zLsijHZH2vK4ccLRacheFWMt2OH5vT4ZHgFQ2uRSJa5t/ioOyzF2i
   NOO6+krZ46L8X6hVvQiLUuGmEkBfqG5Afzfor1nKkFuSmfv3CbzqqIQXN
   yuLeQUm0MUgCqOCAIOYnbf8Gn5xmilMZw4GY6zPO0ybbZygCQuv0kywqj
   861kxapFFdKJ6cOp9xLGE1tVf01Udxgu6M3Z+fMx2oeomkTVMCWkS1cvd
   fFBsABm49x0+Nas2YeIJ5BQRNeVqZ2eSL0V/kmDY3stB1vctYctAIfk1+
   Q==;
X-CSE-ConnectionGUID: whT8OAg/Qv2LHRDqmbaVbQ==
X-CSE-MsgGUID: bMYVmr6ARMWni25HgmI1Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70985223"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70985223"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:32:41 -0800
X-CSE-ConnectionGUID: q4zeM3xdSrmCvHjP542U9Q==
X-CSE-MsgGUID: YzbA6LfvQ1aOtDIw0wE1HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213319384"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Jan 2026 23:32:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlizd-00000000cKB-08sr;
	Fri, 30 Jan 2026 07:32:37 +0000
Date: Fri, 30 Jan 2026 15:32:26 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 f1e60f596d8454b70682d75b9f86f85decfe6299
Message-ID: <202601301520.bHnUUbIw-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2242-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D6583B7F1F
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: f1e60f596d8454b70682d75b9f86f85decfe6299  erofs: separate plain and compressed filesystems formally

elapsed time: 1301m

configs tested: 255
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260130    clang-17
arc                   randconfig-002-20260130    clang-17
arc                        vdk_hs38_defconfig    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g5_defconfig    clang-22
arm                          collie_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-22
arm                         lpc32xx_defconfig    clang-22
arm                   milbeaut_m10v_defconfig    clang-22
arm                          moxart_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                         nhk8815_defconfig    clang-22
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260130    clang-17
arm                   randconfig-002-20260130    clang-17
arm                   randconfig-003-20260130    clang-17
arm                   randconfig-004-20260130    clang-17
arm                           stm32_defconfig    clang-22
arm                           sunxi_defconfig    clang-22
arm                           u8500_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260130    gcc-8.5.0
arm64                 randconfig-002-20260130    gcc-8.5.0
arm64                 randconfig-003-20260130    gcc-8.5.0
arm64                 randconfig-004-20260130    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260130    gcc-8.5.0
csky                  randconfig-002-20260130    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260129    clang-22
hexagon               randconfig-001-20260130    gcc-11.5.0
hexagon               randconfig-002-20260129    clang-22
hexagon               randconfig-002-20260130    gcc-11.5.0
i386                             alldefconfig    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260129    clang-20
i386        buildonly-randconfig-001-20260130    clang-20
i386        buildonly-randconfig-002-20260129    clang-20
i386        buildonly-randconfig-002-20260130    clang-20
i386        buildonly-randconfig-003-20260129    clang-20
i386        buildonly-randconfig-003-20260130    clang-20
i386        buildonly-randconfig-004-20260129    clang-20
i386        buildonly-randconfig-004-20260130    clang-20
i386        buildonly-randconfig-005-20260129    clang-20
i386        buildonly-randconfig-005-20260130    clang-20
i386        buildonly-randconfig-006-20260129    clang-20
i386        buildonly-randconfig-006-20260130    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260130    gcc-14
i386                  randconfig-002-20260130    gcc-14
i386                  randconfig-003-20260130    gcc-14
i386                  randconfig-004-20260130    gcc-14
i386                  randconfig-005-20260130    gcc-14
i386                  randconfig-006-20260130    gcc-14
i386                  randconfig-007-20260130    gcc-14
i386                  randconfig-011-20260130    clang-20
i386                  randconfig-012-20260130    clang-20
i386                  randconfig-013-20260130    clang-20
i386                  randconfig-014-20260130    clang-20
i386                  randconfig-015-20260130    clang-20
i386                  randconfig-016-20260130    clang-20
i386                  randconfig-017-20260130    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260129    clang-22
loongarch             randconfig-001-20260130    gcc-11.5.0
loongarch             randconfig-002-20260129    clang-22
loongarch             randconfig-002-20260130    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5208evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    clang-22
m68k                           virt_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                           jazz_defconfig    clang-22
mips                           jazz_defconfig    gcc-15.2.0
mips                     loongson2k_defconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-22
mips                       rbtx49xx_defconfig    gcc-15.2.0
nios2                         3c120_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260129    clang-22
nios2                 randconfig-001-20260130    gcc-11.5.0
nios2                 randconfig-002-20260129    clang-22
nios2                 randconfig-002-20260130    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260130    gcc-14.3.0
parisc                randconfig-001-20260130    gcc-8.5.0
parisc                randconfig-002-20260130    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     ksi8560_defconfig    clang-22
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    clang-22
powerpc                     rainier_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260130    gcc-14.3.0
powerpc               randconfig-001-20260130    gcc-8.5.0
powerpc               randconfig-002-20260130    gcc-10.5.0
powerpc               randconfig-002-20260130    gcc-8.5.0
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                     tqm8541_defconfig    clang-22
powerpc                 xes_mpc85xx_defconfig    clang-22
powerpc64             randconfig-001-20260130    clang-22
powerpc64             randconfig-001-20260130    gcc-8.5.0
powerpc64             randconfig-002-20260130    clang-22
powerpc64             randconfig-002-20260130    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260130    clang-22
riscv                 randconfig-002-20260130    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260130    clang-22
s390                  randconfig-002-20260130    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260130    clang-22
sh                    randconfig-002-20260130    clang-22
sh                          rsk7269_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260130    clang-22
sparc                 randconfig-002-20260130    clang-22
sparc                       sparc32_defconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260130    clang-22
sparc64               randconfig-002-20260130    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260130    clang-22
um                    randconfig-002-20260130    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260130    clang-20
x86_64      buildonly-randconfig-002-20260130    clang-20
x86_64      buildonly-randconfig-003-20260130    clang-20
x86_64      buildonly-randconfig-004-20260130    clang-20
x86_64      buildonly-randconfig-005-20260130    clang-20
x86_64      buildonly-randconfig-006-20260130    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260129    clang-20
x86_64                randconfig-001-20260130    clang-20
x86_64                randconfig-002-20260129    clang-20
x86_64                randconfig-002-20260130    clang-20
x86_64                randconfig-003-20260129    clang-20
x86_64                randconfig-003-20260130    clang-20
x86_64                randconfig-004-20260129    clang-20
x86_64                randconfig-004-20260130    clang-20
x86_64                randconfig-005-20260129    clang-20
x86_64                randconfig-005-20260130    clang-20
x86_64                randconfig-006-20260129    gcc-14
x86_64                randconfig-006-20260130    clang-20
x86_64                randconfig-011-20260130    clang-20
x86_64                randconfig-012-20260130    clang-20
x86_64                randconfig-013-20260130    clang-20
x86_64                randconfig-014-20260130    clang-20
x86_64                randconfig-015-20260130    clang-20
x86_64                randconfig-016-20260130    clang-20
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
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260130    clang-22
xtensa                randconfig-002-20260130    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

