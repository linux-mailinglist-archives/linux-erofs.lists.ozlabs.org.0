Return-Path: <linux-erofs+bounces-3148-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNuLNHcczGnHPgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3148-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 21:11:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75E370671
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 21:11:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fld5b1MSqz2ygf;
	Wed, 01 Apr 2026 06:11:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774984307;
	cv=none; b=RHG82q20Pys7N93RcrWO11y9exSL0ROQUMidCp6DODirf5deCRzRNlUDekR4oOt+hWmXq+Tm10aF1cthc0xixYpywcFLmJ5H6ZJpJbfYbKS0lue7Yzy2DfSLh7j+xlgmtE8cHzXxifwg/FNoHz2gmVfxJnXCD7E4Wm11kmIFjgwmjIxVsa23TfQ7xsD/j+xeX9bC5qEBIIRhlxJ2WoMwkCVi8mCdpInUkUlpqklLyO2Lxxy4Yl6aHAXv0n1UvhJWP6WjsQUEACxugayJvWlhnuM40X3pcNF9CTS6HR6KsV8ln87qqKD+ElxxYtWqqVD0F/2ePcnDIm/0KcY0Omh1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774984307; c=relaxed/relaxed;
	bh=3hOnV9MSRyK+RPsCePa/Ii7rF6r19RE/Yok9BBe1l7g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G7MrBKaiSoK1D0OlboHPe7g5Sv6dBdpgsrvXBFwUaBuujwTD/Z3/6c7ISXFe/ureTQToxJGo+ItqmHkGoNPpx6smxubuVtyJyiDmrOYha15yRNbQG0X11DeamSJ1eFINrBxb4x4GUuJnyeIKEmpk6ooZ8sJ7cfOhUywnMYY+mQZHRPnWoZ1b1HVzPh93xXxnI7GOUqCxvTVJrsl2w1cVLaoCM9Ce/hPlBS5tht3xwQyfbmKxhYAYEcl2rQVEWtgUeSd7DWFXmW5KiwispifJKHaMJlqJohRKLTzrWGXSl+Eb6wwDxuTQ7W19GRse8/cfUzU9SwOgVI5XJTV/CRMwBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eoE9n1MD; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eoE9n1MD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fld5X3X7Bz2yfl
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 06:11:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774984305; x=1806520305;
  h=date:from:to:cc:subject:message-id;
  bh=lz0mX1tpqyUOpgPJpZYktHv1t3nWPD8FQ1PbNwnFpnI=;
  b=eoE9n1MDMrg3DMMpsbuCtRYVLPzEe5NUR2y+td+TuIjKNjST0tqUfAQA
   Voht/06AIjsIqSvGFXP6W0mCOT0pYH1v+53Rk8aLVhh1bbHZ52ZhAvlQI
   pJipXgcmOO4h0jJFcly46+CzAJQzCT3zNOd7YMtFmzxDya5B+IV3eCMyR
   WSIwzTHpH9zzJRIiwS7k0O1+a4SXUUqyRIXUK8ipo6oYlNzRXA+6mMJ28
   ZtGS/4htWtoUMt8T9iH53txqnb4YCzATekIVVeDlbgDkt0KqwOoSCQ2Fj
   craS+WMd99gAnpoH1NNpqMqZCbVTD2Mjq8HNscA7yNoP5om6FKUvNAjYM
   g==;
X-CSE-ConnectionGUID: e8F+/DhMTMWRKNwyFFVs/w==
X-CSE-MsgGUID: 88M0j+gvTBaYm764PFs6UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93402228"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="93402228"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:11:40 -0700
X-CSE-ConnectionGUID: Y5IHs7hiQRe+LWmUGV7q2A==
X-CSE-MsgGUID: PeOUOKq5SWCPqAIIzCnljw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="264385167"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 31 Mar 2026 12:11:39 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7eUy-000000004Aj-0G5r;
	Tue, 31 Mar 2026 19:11:36 +0000
Date: Wed, 01 Apr 2026 03:10:45 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 1a424156d2ea89d6a996911ea391019d92f4d439
Message-ID: <202604010337.nVDMgYOq-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3148-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 2E75E370671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 1a424156d2ea89d6a996911ea391019d92f4d439  erofs: ensure all folios are managed in erofs_try_to_free_all_cached_folios()

elapsed time: 746m

configs tested: 180
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
arc                   randconfig-001-20260331    clang-23
arc                   randconfig-002-20260331    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260331    clang-23
arm                   randconfig-002-20260331    clang-23
arm                   randconfig-003-20260331    clang-23
arm                   randconfig-004-20260331    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260331    clang-18
arm64                 randconfig-002-20260331    clang-18
arm64                 randconfig-003-20260331    clang-18
arm64                 randconfig-004-20260331    clang-18
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260331    clang-18
csky                  randconfig-002-20260331    clang-18
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260401    gcc-15.2.0
hexagon               randconfig-002-20260401    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260331    clang-20
i386        buildonly-randconfig-002-20260331    clang-20
i386        buildonly-randconfig-003-20260331    clang-20
i386        buildonly-randconfig-004-20260331    clang-20
i386        buildonly-randconfig-005-20260331    clang-20
i386        buildonly-randconfig-006-20260331    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260331    gcc-14
i386                  randconfig-002-20260331    gcc-14
i386                  randconfig-003-20260331    gcc-14
i386                  randconfig-004-20260331    gcc-14
i386                  randconfig-005-20260331    gcc-14
i386                  randconfig-006-20260331    gcc-14
i386                  randconfig-007-20260331    gcc-14
i386                  randconfig-011-20260331    clang-20
i386                  randconfig-012-20260331    clang-20
i386                  randconfig-013-20260331    clang-20
i386                  randconfig-014-20260331    clang-20
i386                  randconfig-015-20260331    clang-20
i386                  randconfig-016-20260331    clang-20
i386                  randconfig-017-20260331    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    gcc-15.2.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260401    gcc-15.2.0
nios2                 randconfig-002-20260401    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260331    clang-23
parisc                randconfig-002-20260331    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    clang-23
powerpc               randconfig-001-20260331    clang-23
powerpc               randconfig-002-20260331    clang-23
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20260331    clang-23
powerpc64             randconfig-002-20260331    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260331    gcc-15.2.0
riscv                 randconfig-002-20260331    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260331    gcc-15.2.0
s390                  randconfig-002-20260331    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260331    gcc-15.2.0
sh                    randconfig-002-20260331    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260331    gcc-15.2.0
sparc                 randconfig-002-20260331    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260331    gcc-15.2.0
sparc64               randconfig-002-20260331    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260331    gcc-15.2.0
um                    randconfig-002-20260331    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260331    clang-20
x86_64      buildonly-randconfig-002-20260331    clang-20
x86_64      buildonly-randconfig-003-20260331    clang-20
x86_64      buildonly-randconfig-004-20260331    clang-20
x86_64      buildonly-randconfig-005-20260331    clang-20
x86_64      buildonly-randconfig-006-20260331    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260331    gcc-14
x86_64                randconfig-002-20260331    gcc-14
x86_64                randconfig-003-20260331    gcc-14
x86_64                randconfig-004-20260331    gcc-14
x86_64                randconfig-005-20260331    gcc-14
x86_64                randconfig-006-20260331    gcc-14
x86_64                randconfig-011-20260331    clang-20
x86_64                randconfig-012-20260331    clang-20
x86_64                randconfig-013-20260331    clang-20
x86_64                randconfig-014-20260331    clang-20
x86_64                randconfig-015-20260331    clang-20
x86_64                randconfig-016-20260331    clang-20
x86_64                randconfig-071-20260331    clang-20
x86_64                randconfig-072-20260331    clang-20
x86_64                randconfig-073-20260331    clang-20
x86_64                randconfig-074-20260331    clang-20
x86_64                randconfig-075-20260331    clang-20
x86_64                randconfig-076-20260331    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260331    gcc-15.2.0
xtensa                randconfig-002-20260331    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

