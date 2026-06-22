Return-Path: <linux-erofs+bounces-3721-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p83mMmaBOWpQugcAu9opvQ
	(envelope-from <linux-erofs+bounces-3721-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 20:39:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B68B6B1D0C
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 20:39:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hbcQA5Zu;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3721-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3721-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkcS14mFsz2yVd;
	Tue, 23 Jun 2026 04:39:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782153569;
	cv=none; b=e2bkE7zlkLfkeuER7nq4lTU/S5LgPx/c7keIMPwKN1j/5CiFv2V2OtgTts8sDDo8j2bAqpL11NlKw3AT0/41IKbJPi1hx4hRNQOB2rldagH2odo6C4TgDDK+3egqVfnejxp7bCXacCEu9IJGTlgw/zZll+9LKYUSnh1yLOyxFy8xgHPrPBfkBEroTh/U6xFDm3MYuMEpTXuSb4cRYBp+6AkhvNBDAzYwkwZ0ZH3CXoz5SoRGSTExqwcnqphMewHq72JfUYBaLwIcR0ruZ3fB1ZGcQG9H2nnji9QWKJdnlY7zGPLph+UqklshMMxuCOV9AC1nd3ZaRST/Ic+H/DzEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782153569; c=relaxed/relaxed;
	bh=KUQjFykSg7tlUCDJadzCS3+xK9/AdRWzudcaEhCUCUo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GjtTtakn/B+T9iKNS6ReD5cDS1HrD+ujrJ9t+4xAsEzi5ZG52U9dkfN83TjaLH+qbyrenUp1a1ekRGF0LGXOjomaOQl/a6zYfumLXZa6KDGofmc9hrZk0kBdg3via2yqHcjkzVswT0S0V4eHxq+R6u6tf+JSk7cmFVFJYUmGmtE8IK0K9R3N6TFCSax1ZxVt8ML89wlPTFeNrOEyU9ryuHg8Zc8Guq3Hy63SyVS/rQR/SCyIwYObGPDEcECLIOoMwvMPnWZhM1CBfA8PH+u0kS7K+b5mTT+VIyWpM+wcfoG7zTcXIZLVyrzrs+d42C5QAN/FZ6zhcHfq20I3P8u74Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hbcQA5Zu; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkcRx4L1wz2yVZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 04:39:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782153566; x=1813689566;
  h=date:from:to:cc:subject:message-id;
  bh=cdeHKk7LIi4IkmWPErnYa2y67GXzj0XJaj4sLxNaNKU=;
  b=hbcQA5ZuziRhNpFpeFl25QEM3Au5Rh8SAkW8Cc4O2SxDAZlOB9GIKCh2
   NyHGD45YGT52Y1EtNZ6UHv2Lq4tmmuNsCDpvB+YyMVJiLSX6riH6pM5P3
   Qjm9sxmPLaYKYitvYj+mZysaroXd4huCNummMfVgC3SDJ3NQ45XpzITVx
   7KQQc+5NbKbz1+TgFsuRE01w6od31HZcGUXSuw4nPZbXmbZo98bZUTVpA
   nBAkqcY85pH1v/CRnLKJCQvJxy0ne5/x2QCG8PCv5DGYIG0eiREb2QpZk
   5UlI+LnO+RTQk44FTu/O619a5uwt+JSXwLkFyPxASttdyphO78pvMXBuV
   A==;
X-CSE-ConnectionGUID: tc175RA6RTae4muLy9zR1A==
X-CSE-MsgGUID: 3k32FLY1TZOUqZycwz/Mcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100443384"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="100443384"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 11:39:18 -0700
X-CSE-ConnectionGUID: qvkRJP+KSP+akoCYyqNYXw==
X-CSE-MsgGUID: d/pVOUTqTKSnyCN1hgWxiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="253194308"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Jun 2026 11:39:16 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wbjY9-000000001j1-1G0U;
	Mon, 22 Jun 2026 18:39:13 +0000
Date: Tue, 23 Jun 2026 02:38:59 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 c37460cd9b2fcb61ec66b7eb4fde737e65ec2a56
Message-ID: <202606230248.AqThRF0y-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-3721-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B68B6B1D0C

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: c37460cd9b2fcb61ec66b7eb4fde737e65ec2a56  erofs: remove fscache backend entirely

elapsed time: 901m

configs tested: 210
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260622    gcc-8.5.0
arc                   randconfig-002-20260622    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260622    gcc-8.5.0
arm                   randconfig-002-20260622    gcc-8.5.0
arm                   randconfig-003-20260622    gcc-8.5.0
arm                   randconfig-004-20260622    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260622    gcc-8.5.0
arm64                 randconfig-002-20260622    gcc-8.5.0
arm64                 randconfig-003-20260622    gcc-8.5.0
arm64                 randconfig-004-20260622    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260622    gcc-8.5.0
csky                  randconfig-002-20260622    gcc-8.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-8.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260622    gcc-14
i386        buildonly-randconfig-002-20260622    gcc-14
i386        buildonly-randconfig-003-20260622    gcc-14
i386        buildonly-randconfig-004-20260622    gcc-14
i386        buildonly-randconfig-005-20260622    gcc-14
i386        buildonly-randconfig-006-20260622    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260622    clang-22
i386                  randconfig-002-20260622    clang-22
i386                  randconfig-003-20260622    clang-22
i386                  randconfig-004-20260622    clang-22
i386                  randconfig-005-20260622    clang-22
i386                  randconfig-006-20260622    clang-22
i386                  randconfig-007-20260622    clang-22
i386                  randconfig-011-20260622    gcc-14
i386                  randconfig-012-20260622    gcc-14
i386                  randconfig-013-20260622    gcc-14
i386                  randconfig-014-20260622    gcc-14
i386                  randconfig-015-20260622    gcc-14
i386                  randconfig-016-20260622    gcc-14
i386                  randconfig-017-20260622    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260622    gcc-11.5.0
loongarch             randconfig-001-20260622    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260622    gcc-11.5.0
loongarch             randconfig-002-20260622    gcc-8.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        qi_lb60_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260622    gcc-14.3.0
parisc                         randconfig-002    gcc-14.3.0
parisc                randconfig-002-20260622    gcc-14.3.0
parisc64                            defconfig    clang-23
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260622    gcc-14.3.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260622    gcc-14.3.0
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260622    gcc-14.3.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260622    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260622    gcc-16.1.0
sparc                          randconfig-002    gcc-16.1.0
sparc                 randconfig-002-20260622    gcc-16.1.0
sparc                       sparc32_defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-16.1.0
sparc64               randconfig-001-20260622    gcc-16.1.0
sparc64                        randconfig-002    gcc-16.1.0
sparc64               randconfig-002-20260622    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-16.1.0
um                    randconfig-001-20260622    gcc-16.1.0
um                             randconfig-002    gcc-16.1.0
um                    randconfig-002-20260622    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260622    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260622    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260622    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260622    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260622    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260622    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260622    clang-22
x86_64                randconfig-002-20260622    clang-22
x86_64                randconfig-003-20260622    clang-22
x86_64                randconfig-004-20260622    clang-22
x86_64                randconfig-005-20260622    clang-22
x86_64                randconfig-006-20260622    clang-22
x86_64                randconfig-011-20260622    clang-22
x86_64                randconfig-012-20260622    clang-22
x86_64                randconfig-013-20260622    clang-22
x86_64                randconfig-014-20260622    clang-22
x86_64                randconfig-015-20260622    clang-22
x86_64                randconfig-016-20260622    clang-22
x86_64                randconfig-071-20260622    gcc-14
x86_64                randconfig-072-20260622    gcc-14
x86_64                randconfig-073-20260622    gcc-14
x86_64                randconfig-074-20260622    gcc-14
x86_64                randconfig-075-20260622    gcc-14
x86_64                randconfig-076-20260622    gcc-14
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
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-16.1.0
xtensa                randconfig-001-20260622    gcc-16.1.0
xtensa                         randconfig-002    gcc-16.1.0
xtensa                randconfig-002-20260622    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

