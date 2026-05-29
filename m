Return-Path: <linux-erofs+bounces-3490-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKxJMgnsGWrDzwgAu9opvQ
	(envelope-from <linux-erofs+bounces-3490-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2026 21:42:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B80607F56
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2026 21:41:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRtz65WXDz2yN8;
	Sat, 30 May 2026 05:41:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780083714;
	cv=none; b=TJLq9yN36ec6teZUluxGCZkr8Gg0R8s9N/Fj4aalgPoHgAAvP8stdK49eNUKpOSYjJ3dR6gO9Y7F94Sloc2r5L9YVMkHB/v5/Gur1T6vV4VRSYDQCiXPlma+J2ihsBHq7t7Juvw4n/VS0fE/Gr79cZCszZq2amUVkzYAOACIq3tZn5FdT4l2h6HIRrAfSgtSNPhv3eihXDyNlNruOBeebWZu1gZT87WW35Sm4a6dSCPhlbnA3lHJeTRCrk1dcQdCMWx7UbCkj++WFddU26BrKZhSVeQao6LfG03LybTEvsyL3c2KhF6ncZ2bQZolk58JByTnOwSqqpIZNzpqTDJZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780083714; c=relaxed/relaxed;
	bh=e+/blPjWSl4R+mwuMbc2al6PF2WJRPT4VpYdsrZJx30=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mHbLI7UxU8rAld6FoEMalkBB1VIM6M0eDdDYjnNS0Y0bSI2S/R7G6iPppdKh58OvZQKdSAsDClEMwTqzqLf2w7bAc+4mYWHT1tlrjSwtDjugFfxiujfoyX28fKuUkUeJ9zViSwW0xoKm41fXbtc4ajFZBqQ7kcoYWTFS8c0g5TWrTmLCntSuU1vjYhwXcrkXLqkeJnwlE63OEOo3MzrRNXf/sbRU5ZZijKyoiKzVM82gKnAE+/Dx0aRGTsKzKmQIhp84bKRWnePsaJfz4H9seWpEfx+o8PmnAWf+v0n+ssHhshd5UGiOJ67cTNtkuT3m6zgrhtF+GKLX2qIG1daGIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QVrzryqo; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QVrzryqo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRtz42LqDz2xmX
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 May 2026 05:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780083712; x=1811619712;
  h=date:from:to:cc:subject:message-id;
  bh=qLlIZ7FKNdhyaVznP0NEqIakPrkX/3MV4h3SisqKsM4=;
  b=QVrzryqoMpcTZM7Z46w/FT4JK0mVfMC8one8T91ws/F1nryFsISzV7iV
   j3RsbPZXq5xoL1IyQy3we2pTDLyAQVeiMp1C3zR2HolGu3rb5BpcpckRN
   kmMs8NIz9WpHbB81SABv+aKEDdUyXBnViqsf7Gjf8XiBUD4s/Kc3fSsEu
   2MuHdZp6lE6jfCvahqBfatYIshuv4rNFuGU6XXYH4xxCNl259PpFFF8UV
   YadSy2S3uM5pcTmGWFkAuX+gtGeKWw1En85DfZMav98eomJ4WcFL1e6+k
   5l5jrgQOAYhuNL6OtPHVW0+uDi94jjKIqOfmSJfJG3vBCVXHB28HRoAzy
   g==;
X-CSE-ConnectionGUID: b/CFBTZNSyexK7W8PhxtBw==
X-CSE-MsgGUID: rTMC4wUrQFOSRvZ2py5JJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80085036"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="80085036"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 12:41:47 -0700
X-CSE-ConnectionGUID: 3Db4BBcQQ3ugvqkO1FyjrA==
X-CSE-MsgGUID: BVe9oISEQdqusHvml2dJjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="236584814"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 May 2026 12:41:46 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wT35T-000000007dC-33O8;
	Fri, 29 May 2026 19:41:43 +0000
Date: Sat, 30 May 2026 03:41:13 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 1aee05e814d292064bf5fa15733741040cdc48ba
Message-ID: <202605300304.b1YJpidu-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
	TAGGED_FROM(0.00)[bounces-3490-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 05B80607F56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 1aee05e814d292064bf5fa15733741040cdc48ba  erofs: fix use-after-free on sbi->sync_decompress

elapsed time: 894m

configs tested: 198
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    clang-23
arc                   randconfig-001-20260529    clang-23
arc                            randconfig-002    clang-23
arc                   randconfig-002-20260529    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    clang-17
arm                            randconfig-001    clang-23
arm                   randconfig-001-20260529    clang-23
arm                            randconfig-002    clang-23
arm                   randconfig-002-20260529    clang-23
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260529    clang-23
arm                            randconfig-004    clang-23
arm                   randconfig-004-20260529    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260529    clang-23
arm64                 randconfig-002-20260529    clang-23
arm64                 randconfig-003-20260529    clang-23
arm64                 randconfig-004-20260529    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260529    clang-23
csky                  randconfig-002-20260529    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260529    gcc-8.5.0
hexagon               randconfig-001-20260530    clang-23
hexagon               randconfig-002-20260529    gcc-8.5.0
hexagon               randconfig-002-20260530    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260529    gcc-12
i386        buildonly-randconfig-002-20260529    gcc-12
i386        buildonly-randconfig-003-20260529    gcc-12
i386        buildonly-randconfig-004-20260529    gcc-12
i386        buildonly-randconfig-005-20260529    gcc-12
i386        buildonly-randconfig-006-20260529    gcc-12
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260529    gcc-14
i386                  randconfig-002-20260529    gcc-14
i386                  randconfig-003-20260529    gcc-14
i386                  randconfig-004-20260529    gcc-14
i386                  randconfig-005-20260529    gcc-14
i386                  randconfig-006-20260529    gcc-14
i386                  randconfig-007-20260529    gcc-14
i386                  randconfig-011-20260529    gcc-14
i386                  randconfig-012-20260529    gcc-14
i386                  randconfig-013-20260529    gcc-14
i386                  randconfig-014-20260529    gcc-14
i386                  randconfig-015-20260529    gcc-14
i386                  randconfig-016-20260529    gcc-14
i386                  randconfig-017-20260529    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260529    gcc-8.5.0
loongarch             randconfig-001-20260530    clang-23
loongarch             randconfig-002-20260529    gcc-8.5.0
loongarch             randconfig-002-20260530    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260529    gcc-8.5.0
nios2                 randconfig-001-20260530    clang-23
nios2                 randconfig-002-20260529    gcc-8.5.0
nios2                 randconfig-002-20260530    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    clang-19
parisc                randconfig-001-20260529    clang-19
parisc                         randconfig-002    clang-19
parisc                randconfig-002-20260529    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    clang-19
powerpc               randconfig-001-20260529    clang-19
powerpc                        randconfig-002    clang-19
powerpc               randconfig-002-20260529    clang-19
powerpc64                      randconfig-001    clang-19
powerpc64             randconfig-001-20260529    clang-19
powerpc64                      randconfig-002    clang-19
powerpc64             randconfig-002-20260529    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-15.2.0
riscv                 randconfig-001-20260529    gcc-15.2.0
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260529    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260529    gcc-15.2.0
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260529    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260529    gcc-15.2.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260529    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260529    gcc-11.5.0
sparc                 randconfig-002-20260529    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260529    gcc-11.5.0
sparc64               randconfig-002-20260529    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260529    gcc-11.5.0
um                    randconfig-002-20260529    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260529    gcc-14
x86_64      buildonly-randconfig-002-20260529    gcc-14
x86_64      buildonly-randconfig-003-20260529    gcc-14
x86_64      buildonly-randconfig-004-20260529    gcc-14
x86_64      buildonly-randconfig-005-20260529    gcc-14
x86_64      buildonly-randconfig-006-20260529    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260529    clang-20
x86_64                randconfig-002-20260529    clang-20
x86_64                randconfig-003-20260529    clang-20
x86_64                randconfig-004-20260529    clang-20
x86_64                randconfig-005-20260529    clang-20
x86_64                randconfig-006-20260529    clang-20
x86_64                randconfig-011-20260529    clang-20
x86_64                randconfig-012-20260529    clang-20
x86_64                randconfig-013-20260529    clang-20
x86_64                randconfig-014-20260529    clang-20
x86_64                randconfig-015-20260529    clang-20
x86_64                randconfig-016-20260529    clang-20
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260529    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260529    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260529    clang-20
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260529    clang-20
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260529    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260529    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260529    gcc-11.5.0
xtensa                randconfig-002-20260529    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

