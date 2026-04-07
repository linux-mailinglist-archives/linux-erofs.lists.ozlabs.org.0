Return-Path: <linux-erofs+bounces-3217-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CWjCScu1WmF2AcAu9opvQ
	(envelope-from <linux-erofs+bounces-3217-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 18:17:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD7D3B1A94
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 18:17:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqrvQ4pldz2yZ3;
	Wed, 08 Apr 2026 02:17:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775578658;
	cv=none; b=Pn5ibJt7aL0sGb1FNz2FVwmbrVZbwKl1cw7nBvg8AxBjfxG9K3bqYQfZG4MwQPQexoMphiz4u8ugk6s6UnYv5uQGdsz+2oBXfY6T2KEHex8dnWPwESy8v8FsAPaizAvGEAT1Ii+u7jqNrra9PAadcpoO/hz9ivd7zA1uvGh/xMR1VNxU38TqA4C3sXxnEtxTiWr/k5EQztvwoY4Qjvg7euqp9y55msq+SyRrIaDuRRqxfUOBSKp91YD6sZBxBiIcK82YKxq8YefvCUY/l8r/vj84rK368y1rn6D3PMyL17EPOQYKAbLFZqKZbttjs7BsrmLHZXQCpFW4T01eKmLZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775578658; c=relaxed/relaxed;
	bh=40cLXA4Yaoa+x0YbRCj838DGTWUH4K6/b9upVwoHcUk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XRW2jWAcXOnx6A+x2Dw1Xap0//zn0oLIW39QuODaDC1OV6Nzh+AgbmipmpGOxQDr+0WB9fjhd/m9OVfUTFztKlYJjGODca+CovjiogbTKpVTUkKhG9BtUHVM+cyYa5jY+ibnumqXLdw3xTzFkDfCvOIso1yJYtiyACioEx+mzjuVIvpscHuBx2w4C7a9Z+ozztureq50LB8nBS2VcBIk5YG39FsrcRLjPED6cBO6dRyrwLylKmQ+Ehjauv9tm4gEqC1JytJ/pSXRgAB8mawV+pNuOtYuaKwwiFOvn9GZYGaSOKHNdi2KB6ZNbjnEmXMhpQKg1is5wfOfpD0KRCGwRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a4vsOcF6; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a4vsOcF6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqrvM3VtVz2ySC
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Apr 2026 02:17:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775578656; x=1807114656;
  h=date:from:to:cc:subject:message-id;
  bh=XtltWxcGTlaU6HisvMnLnUQ96I9BCTJM74RnVmTZFdI=;
  b=a4vsOcF6rZiDYilSMduie1yJO5MxzVFAv7rK1328lG2KF7nBiMQS8YN3
   eB4ZAZ0jLYiYiUeaoGvUITrslYvBck8TVbHHwyhBL2u8Afou3W8OS0SAn
   weZE6CCb4r74+yLvFoHcztbF/svKiZYkOJEH/khE3hqo+Tc06J6rruEjT
   dTVPvpRYTitaO0knVjmT9W32FlrszpJwKGO1P40035FmMvKXqtHdc3DS9
   rpclVayjv2LDiamYCRVUwfJ6mLNTckwhmZbC/mO5OGDKSbqPYA4RQ48Ti
   KR6z9ZxY4ikKokrgztlmZopLQwVv09kR7Hd1jK4LVmmMNMYUF4ul1kIob
   w==;
X-CSE-ConnectionGUID: ewAOset8SeaBTD9t9CO9YQ==
X-CSE-MsgGUID: +UbdyvFwSqKMbZ1RSIILEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80434495"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="80434495"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 09:17:29 -0700
X-CSE-ConnectionGUID: XMGJrbJwTq2+QNcm/+XJRg==
X-CSE-MsgGUID: Y7SN6qVyQYOVfXi2N5l1rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="233179892"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2026 09:17:27 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wA97E-000000000nV-2IAy;
	Tue, 07 Apr 2026 16:17:24 +0000
Date: Wed, 08 Apr 2026 00:16:59 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 63c2f06198ca7513433f1c92f2c654869d72417e
Message-ID: <202604080049.5fuPNmqz-lkp@intel.com>
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
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3217-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: CAD7D3B1A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 63c2f06198ca7513433f1c92f2c654869d72417e  erofs: handle 48-bit blocks/uniaddr for extra devices

elapsed time: 729m

configs tested: 183
configs skipped: 8

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
arc                   randconfig-001-20260407    clang-23
arc                   randconfig-002-20260407    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    clang-23
arm                   randconfig-001-20260407    clang-23
arm                   randconfig-002-20260407    clang-23
arm                   randconfig-003-20260407    clang-23
arm                   randconfig-004-20260407    clang-23
arm                           sama5_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260407    gcc-9.5.0
arm64                 randconfig-002-20260407    gcc-13.4.0
arm64                 randconfig-002-20260407    gcc-9.5.0
arm64                 randconfig-003-20260407    gcc-8.5.0
arm64                 randconfig-003-20260407    gcc-9.5.0
arm64                 randconfig-004-20260407    clang-23
arm64                 randconfig-004-20260407    gcc-9.5.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260407    gcc-13.4.0
csky                  randconfig-001-20260407    gcc-9.5.0
csky                  randconfig-002-20260407    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260407    clang-23
hexagon               randconfig-002-20260407    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260407    clang-20
i386        buildonly-randconfig-002-20260407    clang-20
i386        buildonly-randconfig-003-20260407    clang-20
i386        buildonly-randconfig-004-20260407    clang-20
i386        buildonly-randconfig-005-20260407    clang-20
i386        buildonly-randconfig-006-20260407    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260407    gcc-14
i386                  randconfig-002-20260407    gcc-14
i386                  randconfig-003-20260407    gcc-14
i386                  randconfig-004-20260407    gcc-14
i386                  randconfig-005-20260407    gcc-14
i386                  randconfig-006-20260407    gcc-14
i386                  randconfig-007-20260407    gcc-14
i386                  randconfig-011-20260407    clang-20
i386                  randconfig-012-20260407    clang-20
i386                  randconfig-013-20260407    clang-20
i386                  randconfig-014-20260407    clang-20
i386                  randconfig-015-20260407    clang-20
i386                  randconfig-016-20260407    clang-20
i386                  randconfig-017-20260407    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260407    clang-23
loongarch             randconfig-002-20260407    clang-23
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
nios2                 randconfig-001-20260407    clang-23
nios2                 randconfig-002-20260407    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                   de0_nano_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260407    gcc-10.5.0
parisc                randconfig-002-20260407    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      chrp32_defconfig    clang-19
powerpc                     mpc512x_defconfig    clang-23
powerpc               randconfig-001-20260407    gcc-10.5.0
powerpc               randconfig-002-20260407    gcc-10.5.0
powerpc64             randconfig-001-20260407    gcc-10.5.0
powerpc64             randconfig-002-20260407    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260407    clang-23
riscv                 randconfig-001-20260407    gcc-14.3.0
riscv                 randconfig-002-20260407    gcc-12.5.0
riscv                 randconfig-002-20260407    gcc-14.3.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260407    gcc-14.3.0
s390                  randconfig-002-20260407    clang-20
s390                  randconfig-002-20260407    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260407    gcc-13.4.0
sh                    randconfig-001-20260407    gcc-14.3.0
sh                    randconfig-002-20260407    gcc-14.3.0
sh                    randconfig-002-20260407    gcc-15.2.0
sh                           se7206_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260407    gcc-12
sparc                 randconfig-002-20260407    gcc-12
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260407    gcc-12
sparc64               randconfig-002-20260407    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260407    gcc-12
um                    randconfig-002-20260407    gcc-12
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260407    gcc-14
x86_64      buildonly-randconfig-002-20260407    gcc-14
x86_64      buildonly-randconfig-003-20260407    gcc-14
x86_64      buildonly-randconfig-004-20260407    gcc-14
x86_64      buildonly-randconfig-005-20260407    gcc-14
x86_64      buildonly-randconfig-006-20260407    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260407    gcc-14
x86_64                randconfig-002-20260407    gcc-14
x86_64                randconfig-003-20260407    gcc-14
x86_64                randconfig-004-20260407    gcc-14
x86_64                randconfig-005-20260407    gcc-14
x86_64                randconfig-006-20260407    gcc-14
x86_64                randconfig-011-20260407    clang-20
x86_64                randconfig-012-20260407    clang-20
x86_64                randconfig-013-20260407    clang-20
x86_64                randconfig-014-20260407    clang-20
x86_64                randconfig-015-20260407    clang-20
x86_64                randconfig-016-20260407    clang-20
x86_64                randconfig-071-20260407    clang-20
x86_64                randconfig-072-20260407    clang-20
x86_64                randconfig-073-20260407    clang-20
x86_64                randconfig-074-20260407    clang-20
x86_64                randconfig-075-20260407    clang-20
x86_64                randconfig-076-20260407    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260407    gcc-12
xtensa                randconfig-002-20260407    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

