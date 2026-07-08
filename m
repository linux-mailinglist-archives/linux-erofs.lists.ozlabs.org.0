Return-Path: <linux-erofs+bounces-3867-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D3QsFLGoTmpjRgIAu9opvQ
	(envelope-from <linux-erofs+bounces-3867-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 21:44:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3AB729F20
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 21:44:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=a+b6HXpq;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3867-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3867-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwT7x4GHXz2xpn;
	Thu, 09 Jul 2026 05:44:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783539885;
	cv=none; b=JUAqOtMRiPTfTbXzmBrBIBIEvdPRJR4LSlUdU0Lr3eV8RjqYLr1yO9CKRRozH87jiJwSvnuEIk8hdhk2J7wI4oBqHQdtgW3HKOP016Kl6VNHASe+xNANeRKXAGheQ6NIt54TfEaT/dxyHVngrLcj0buQf5ec/YzXwsT/fOtD4vDF4/02DCgeL02staZ6QLOSuU0jUXhdfbneZC2tR8ncd9nrg9mMji7skk3iaruUNwRvY5lqQiqYSiMyBimwq6+unCMInkKt+fwuIRtAvC7ferSwk1Gd9rSxH1/PRp5UePBeJuwc07ffAXRojjF2Q66G2lhu4XfZyv+ouJnbZ3S65g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783539885; c=relaxed/relaxed;
	bh=FGgyGJ96sJn1ZeGW9xmP25s4NIe+zu6labgMOiSnRSI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d4LWJuEG4dmb6G9H+eLKzwP/i48P3kkcX+Ap8/YqbLU3do+fukg8Q3IsYl3Prvdtrlok/6Idkbs5ch16BGIX75UPv7VFOdAVmo8LWAFlvH//5th3xABt5eEL/kVFpLO5Prm0SK4x22M6dPvvPhayzj+zX77RHJajybxFzpB/4234640uBo0YbEpv61UclsYL6RAooICusebYV4LbvTFxuynsNfKknx755ouJ6TTs2iwyEMu4FVx5YW/DJw2M71Rw8FfZ1X/Cnvl5M6Cn4o/d0E2/MD9+oNxnWfZpa2pXeKnC56EOY6BKiszKyMqqh7L4zdOAFZU3cs82qsPy6xDpzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a+b6HXpq; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwT7s57Fgz2xm3
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jul 2026 05:44:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783539882; x=1815075882;
  h=date:from:to:cc:subject:message-id;
  bh=rgs83lyFEgGbLbOiNpPm3kKJMTdc0hqwkU34AGXaoPU=;
  b=a+b6HXpqlPYUVcko0AJP4HGMA/7yPUSeTAcpwF72tX9muWxr9PR5KETu
   W5IRJauoRDYws3Ef3im+hH3OCYKzUgpgfnqib2QrxWrrJ4IVvrVUyFuA7
   AFWoQTLbwG0wPH44m4G2rENoEFszvxmSMG+WY5gEHRrVmjjdLZ8HWdhIk
   DLg4RxOOw04yl5YL6z/5GFN9HZSSH7bD45xb6y0K0vi5GkBLkSs7qOyRQ
   On3mrXA0eSr7RoFZ5fwmYX09mG6M66iFkoNj5W3/OFnkf35QvjqnsUA29
   W4+pZbqI+jj9EjLB5UEGMwHBIsOaK0+968OaZ+cvdGBSUySNOI7lpIUjf
   w==;
X-CSE-ConnectionGUID: /FsXoDnHS0Co+VB4N1vB+A==
X-CSE-MsgGUID: EzEOt8N1S3e3qoq1sIOqcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84187677"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84187677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:44:20 -0700
X-CSE-ConnectionGUID: wjyTl+BAT4OsDj49OZUewA==
X-CSE-MsgGUID: j5uB9aHdSSSBXXOKt9Ag4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="284478201"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 08 Jul 2026 12:44:18 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whYBr-00000000GnN-2YV8;
	Wed, 08 Jul 2026 19:44:15 +0000
Date: Thu, 09 Jul 2026 03:43:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 95e19a4d8dd3072d51209081a29467d887c84158
Message-ID: <202607090337.1u1oYxJD-lkp@intel.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3867-lists,linux-erofs=lfdr.de];
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
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,intel.com:mid,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D3AB729F20

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 95e19a4d8dd3072d51209081a29467d887c84158  erofs: get rid of erofs_is_ishare_inode() helper

elapsed time: 728m

configs tested: 275
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260708    gcc-13.4.0
arc                   randconfig-001-20260709    gcc-8.5.0
arc                   randconfig-002-20260708    gcc-13.4.0
arc                   randconfig-002-20260709    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260708    gcc-13.4.0
arm                   randconfig-001-20260709    gcc-8.5.0
arm                   randconfig-002-20260708    gcc-13.4.0
arm                   randconfig-002-20260709    gcc-8.5.0
arm                   randconfig-003-20260708    gcc-13.4.0
arm                   randconfig-003-20260709    gcc-8.5.0
arm                   randconfig-004-20260708    gcc-13.4.0
arm                   randconfig-004-20260709    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260708    gcc-9.5.0
arm64                 randconfig-002-20260708    gcc-9.5.0
arm64                 randconfig-003-20260708    gcc-9.5.0
arm64                 randconfig-004-20260708    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260708    gcc-9.5.0
csky                  randconfig-002-20260708    gcc-9.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260708    gcc-11.5.0
hexagon               randconfig-001-20260708    gcc-13.4.0
hexagon               randconfig-001-20260709    clang-18
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260708    gcc-11.5.0
hexagon               randconfig-002-20260708    gcc-13.4.0
hexagon               randconfig-002-20260709    clang-18
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260708    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260708    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260708    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260708    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260708    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260708    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260708    clang-22
i386                  randconfig-002-20260708    clang-22
i386                  randconfig-003-20260708    clang-22
i386                  randconfig-004-20260708    clang-22
i386                  randconfig-005-20260708    clang-22
i386                  randconfig-006-20260708    clang-22
i386                  randconfig-007-20260708    clang-22
i386                  randconfig-011-20260708    gcc-14
i386                  randconfig-011-20260709    gcc-14
i386                  randconfig-012-20260708    gcc-14
i386                  randconfig-012-20260709    gcc-14
i386                  randconfig-013-20260708    gcc-14
i386                  randconfig-013-20260709    gcc-14
i386                  randconfig-014-20260708    gcc-14
i386                  randconfig-014-20260709    gcc-14
i386                  randconfig-015-20260708    gcc-14
i386                  randconfig-015-20260709    gcc-14
i386                  randconfig-016-20260708    gcc-14
i386                  randconfig-016-20260709    gcc-14
i386                  randconfig-017-20260708    gcc-14
i386                  randconfig-017-20260709    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260708    gcc-11.5.0
loongarch             randconfig-001-20260708    gcc-13.4.0
loongarch             randconfig-001-20260709    clang-18
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260708    gcc-11.5.0
loongarch             randconfig-002-20260708    gcc-13.4.0
loongarch             randconfig-002-20260709    clang-18
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260708    gcc-11.5.0
nios2                 randconfig-001-20260708    gcc-13.4.0
nios2                 randconfig-001-20260709    clang-18
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260708    gcc-11.5.0
nios2                 randconfig-002-20260708    gcc-13.4.0
nios2                 randconfig-002-20260709    clang-18
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260708    clang-22
parisc                randconfig-002-20260708    clang-22
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260708    clang-22
powerpc               randconfig-002-20260708    clang-22
powerpc                    socrates_defconfig    gcc-16.1.0
powerpc                     tqm8555_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260708    clang-22
powerpc64             randconfig-002-20260708    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260708    clang-23
riscv                 randconfig-001-20260709    clang-22
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260708    clang-23
riscv                 randconfig-002-20260709    clang-22
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260708    clang-23
s390                  randconfig-001-20260709    clang-22
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260708    clang-23
s390                  randconfig-002-20260709    clang-22
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260708    clang-23
sh                    randconfig-001-20260709    clang-22
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260708    clang-23
sh                    randconfig-002-20260709    clang-22
sh                          sdk7780_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260708    gcc-8.5.0
sparc                 randconfig-001-20260709    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260708    gcc-8.5.0
sparc                 randconfig-002-20260709    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260708    gcc-8.5.0
sparc64               randconfig-001-20260709    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260708    gcc-8.5.0
sparc64               randconfig-002-20260709    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260708    gcc-8.5.0
um                    randconfig-001-20260709    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260708    gcc-8.5.0
um                    randconfig-002-20260709    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260708    gcc-12
x86_64               buildonly-randconfig-002    gcc-12
x86_64      buildonly-randconfig-002-20260708    gcc-12
x86_64               buildonly-randconfig-003    gcc-12
x86_64      buildonly-randconfig-003-20260708    gcc-12
x86_64               buildonly-randconfig-004    gcc-12
x86_64      buildonly-randconfig-004-20260708    gcc-12
x86_64               buildonly-randconfig-005    gcc-12
x86_64      buildonly-randconfig-005-20260708    gcc-12
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20260708    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260708    gcc-14
x86_64                randconfig-001-20260709    gcc-14
x86_64                randconfig-002-20260708    gcc-14
x86_64                randconfig-002-20260709    gcc-14
x86_64                randconfig-003-20260708    gcc-14
x86_64                randconfig-003-20260709    gcc-14
x86_64                randconfig-004-20260708    gcc-14
x86_64                randconfig-004-20260709    gcc-14
x86_64                randconfig-005-20260708    gcc-14
x86_64                randconfig-005-20260709    gcc-14
x86_64                randconfig-006-20260708    gcc-14
x86_64                randconfig-006-20260709    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260708    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260708    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260708    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260708    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260708    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260708    clang-22
x86_64                randconfig-071-20260708    clang-22
x86_64                randconfig-072-20260708    clang-22
x86_64                randconfig-073-20260708    clang-22
x86_64                randconfig-074-20260708    clang-22
x86_64                randconfig-075-20260708    clang-22
x86_64                randconfig-076-20260708    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260708    gcc-8.5.0
xtensa                randconfig-001-20260709    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260708    gcc-8.5.0
xtensa                randconfig-002-20260709    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

