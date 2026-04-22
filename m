Return-Path: <linux-erofs+bounces-3354-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDPxEWhE6GkfIAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3354-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Apr 2026 05:45:44 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A3441DD9
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Apr 2026 05:45:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0lVk32XLz2xlm;
	Wed, 22 Apr 2026 13:45:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776829534;
	cv=none; b=PXdXV7tJQQaBmFsNXU1hOjhL61c2CPZb1VS31kfD1GXnv7s1iatN5dorZJ7Nc1kTgF515F0OEy6owmhoVgMG93CnhJAXnar192blRzK+0mKA5JpcxcZdFPZw1XtWM8Hbg+CxrUApn3Ju1qIZcN31YMATztoY7msPFDChqq6tp00dOV5DpjAJAWxdPYoXJiynejQOJR9xNCnibwIffMaYiHRCiZQxGSIgCvT6hI9UL58+dRgSRcDOy9fdBLHntYmhd1IJxWpCNU9CX+0cxaDoPRA1fa1782mSIN9AA6MIj4bltPSB6/CO4Lsl+SvidCKV+SssUjynR9P+1IDvXkI1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776829534; c=relaxed/relaxed;
	bh=njXUEC4P4mKmPEO6TfFiq4gelIwvGZkmcUwQWBJJSq4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FNSfCSLCS5dmshc82H0ioxin5gn7N7XAyVndiQ5AN8/sPybqn0uYIeWliWYiAkuBTJy/JQm0FXUhKNmKFo27L6x4qFvseTJ6vhSiqHTl9wAmIakuJX07mwXiZaxuaJOgquddUlUxb6TfV6pVCY7bEZvDjY28oKHVGj2COVYgLk62cVPs3j3b7+h/j0vY2PZ/whj11yOApGw9yftbxuSly1QlIzS6ky4Iw1VbLYLtkexIqKHGvDTgTJwwU/SXe4uN9JfPuq58O19uoO0xifLW6p6IvdEAhL30RIRqmk4vNrFJBNm3YlvG3TYPC9XAYWVyoXzzQ+eILWXpImyL9+Rb9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LZmeHMPW; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LZmeHMPW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Wed, 22 Apr 2026 13:45:31 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0lVg14qyz2xTh
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Apr 2026 13:45:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776829532; x=1808365532;
  h=date:from:to:cc:subject:message-id;
  bh=w+26KqiB3Pt1bQ/uNv9+iDhHvUgieDPEOFvzEmk5nuA=;
  b=LZmeHMPW3qErhvghQfbRFBy8xO8lFTJWPfI8WSYqsTFEBUVMLKo3ezpe
   WXwpekKnIU/LPSHKMjsoFypUHPQn7UFtSq+da558u8vrqkzH5gH8PhZ2E
   86BpzNp02KnPRp4oB/dTdWQr/A596Wrt2e+ynN0UG6N7zAfv56XpObIZy
   6yKLrauekDNCg/2Bb1Jp9FnVQD6QK0PI6YSdQpzqWIh8Yb5uQmpYi93sb
   2hK6b6YsLnpfkHIqN8yNklI2hO10RzxQ0TH9ifhYwaJovZH8MX5NPexti
   ykvmYHYywHuopDgSTWaTmuysy5lGZyaHwR2d6kA9HdjZm+iYFHZxdNKzZ
   A==;
X-CSE-ConnectionGUID: WtDkjsgzTk2OM1fNYJrGow==
X-CSE-MsgGUID: noOGTaKvRui9oGPaJrna3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88077841"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88077841"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 20:44:19 -0700
X-CSE-ConnectionGUID: AkB1Rn6ZTTuLJH/Xb0z5fQ==
X-CSE-MsgGUID: 6/F7uSMPRPGCO1mfaxjYew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="225729604"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Apr 2026 20:44:17 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFOVb-000000004Ge-0nhW;
	Wed, 22 Apr 2026 03:44:15 +0000
Date: Wed, 22 Apr 2026 11:43:52 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 2d8c7edcb661812249469f4a5b62e9339118846f
Message-ID: <202604221142.CiRExtnO-lkp@intel.com>
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
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-3354-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 450A3441DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 2d8c7edcb661812249469f4a5b62e9339118846f  erofs: unify lcn as u64 for 32-bit platforms

elapsed time: 739m

configs tested: 108
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260422    gcc-9.5.0
arc                   randconfig-002-20260422    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260422    gcc-8.5.0
arm                   randconfig-002-20260422    gcc-8.5.0
arm                   randconfig-003-20260422    clang-20
arm                   randconfig-004-20260422    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260422    gcc-14
i386        buildonly-randconfig-002-20260422    clang-20
i386        buildonly-randconfig-003-20260422    gcc-14
i386                  randconfig-001-20260422    clang-20
i386                  randconfig-002-20260422    gcc-14
i386                  randconfig-003-20260422    clang-20
i386                  randconfig-004-20260422    gcc-14
i386                  randconfig-005-20260422    gcc-14
i386                  randconfig-006-20260422    clang-20
i386                  randconfig-007-20260422    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260422    gcc-14.3.0
parisc                randconfig-002-20260422    gcc-9.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-23
powerpc               randconfig-001-20260422    gcc-13.4.0
powerpc               randconfig-002-20260422    gcc-14.3.0
powerpc64             randconfig-001-20260422    clang-23
powerpc64             randconfig-002-20260422    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-002-20260422    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260422    gcc-14
x86_64      buildonly-randconfig-002-20260422    gcc-14
x86_64      buildonly-randconfig-003-20260422    gcc-14
x86_64      buildonly-randconfig-004-20260422    clang-20
x86_64      buildonly-randconfig-005-20260422    gcc-14
x86_64      buildonly-randconfig-006-20260422    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260422    clang-20
x86_64                randconfig-002-20260422    gcc-14
x86_64                randconfig-003-20260422    gcc-14
x86_64                randconfig-004-20260422    clang-20
x86_64                randconfig-005-20260422    gcc-14
x86_64                randconfig-006-20260422    clang-20
x86_64                randconfig-011-20260422    clang-20
x86_64                randconfig-012-20260422    gcc-14
x86_64                randconfig-013-20260422    clang-20
x86_64                randconfig-014-20260422    clang-20
x86_64                randconfig-015-20260422    gcc-14
x86_64                randconfig-016-20260422    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

