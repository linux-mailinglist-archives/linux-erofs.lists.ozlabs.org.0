Return-Path: <linux-erofs+bounces-2264-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCg2A9wwhWlV9wMAu9opvQ
	(envelope-from <linux-erofs+bounces-2264-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 01:07:56 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C179EF87F7
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 01:07:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6ZD70DfRz2yFQ;
	Fri, 06 Feb 2026 11:07:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770336470;
	cv=none; b=a/cLKbMjFnNc4/tK+o0GEr6dEAsspohaKrnrbOhFWJ7g80TZEyKhwSCvjMFBbvkVhVAj+n60t/zcyLf9zRIVd4ac8kQ9QamO+c595IlyZphfVYL5fI7Thd+mHZqkd3cgK4lI+18bGuPTfyJZBBrF9f0adtcq3flNq6WVJ4CciK8LeLMBV+wzwLnyl2g2WfHo2HOBUQ96QN8PZLUnckgpicUbaCpgPtjOI6DLeE8c1s9XCMxJuOj5UQCtChxZ5qvOqrqRNay7XbYkm92e7JwWG5wGEo1IHnTtnlFBIjn4JFgUYVq/WeOQnOCP6S+V3reeQm4+XYq163MXBxcV9BXDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770336470; c=relaxed/relaxed;
	bh=j/DNhkhjuZpY+HaPrg5sUqPFMmWx6yzHoK2mK47g/ms=;
	h=Date:From:To:Cc:Subject:Message-ID; b=byVWHTfzMpPvyZgjeW0qA/FDhxDf/fQn4TmxyKyO0Gw/SI6gQP1H2kmcztOCcgsJVyLKuifzKCkIZgGYoTsupgOtD6JD1SvSaPhzS4RaIi82IBCZ0lrNg2+updnVmlwwSkzCjZWDrKWhkrTynXb1GZBcAmEeLGuoTPt4z6l2AAmLVeGYT1gztUmmVNNF1qnfsv2YPGQAuDpFeWpa3M7ip6zCo/+Kwj3DWX8GjiWpuRwVOJT2yzcWtb0knz90c7NT4IR9uLTBjNO9XR1dXdgpWIOvGPHYyjXC45+aNg3kQs1hLOmue7Dq+i8twErRLfc8Vc/xOXVkwoQlfPMyqY6ejw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QENnauGe; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QENnauGe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6ZD34cCPz2xqj
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Feb 2026 11:07:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770336468; x=1801872468;
  h=date:from:to:cc:subject:message-id;
  bh=edexn7WFOrcGHeLAeG+9Vtu8fqMeiyRGDb4rxxR5akA=;
  b=QENnauGe87xFP2YBwN8KHAGxK7l4GIsG+ZE0BbHNq4hQI7WS1g64dHTj
   EzGVkz6a7SwgIuzPL2igfATxp/YNAzACZwT5geM4fDQunA93jac1Rk9AX
   4yHG3l4qWtJLegZOFvuy2g30ika2QIktuUIew029Zac4jU9cgC6lBukWH
   aFce/rxAnuNsVXBnwvoiKtsBSQgdSH7oPyY8y3cQQvz1jZYrPd3pgjblN
   srGQN545Q4ohLS/c3ygiiFuZrhChEfYjCL733VLKiVUy12QRQp8pUf/oJ
   YAnq96RiAOX3VxsSTyadtZEmgGtE+ehQF5fax/xjsEo4k61BInMCxZi6C
   A==;
X-CSE-ConnectionGUID: EbeLk/caTAa/qJJMtl8zkg==
X-CSE-MsgGUID: D0zf8JvOSD6gn8drpIVLUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82915599"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82915599"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 16:07:38 -0800
X-CSE-ConnectionGUID: bMjBQ8gfTxKA8VTJsQSc+w==
X-CSE-MsgGUID: HLZUpUxgTs6IO1GGns30Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215307633"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2026 16:07:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo9Nm-00000000kJA-32Ei;
	Fri, 06 Feb 2026 00:07:34 +0000
Date: Fri, 06 Feb 2026 08:06:52 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 8f2fb72fd17eecd5a47c73ce7e228d157e613b80
Message-ID: <202602060844.qyHo1Y37-lkp@intel.com>
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
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-2264-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C179EF87F7
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 8f2fb72fd17eecd5a47c73ce7e228d157e613b80  erofs: update compression algorithm status

elapsed time: 842m

configs tested: 326
configs skipped: 3

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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260205    gcc-8.5.0
arc                   randconfig-001-20260206    gcc-8.5.0
arc                   randconfig-002-20260205    gcc-8.5.0
arc                   randconfig-002-20260206    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                   randconfig-001-20260205    gcc-8.5.0
arm                   randconfig-001-20260206    gcc-8.5.0
arm                   randconfig-002-20260205    gcc-8.5.0
arm                   randconfig-002-20260206    gcc-8.5.0
arm                   randconfig-003-20260205    gcc-8.5.0
arm                   randconfig-003-20260206    gcc-8.5.0
arm                   randconfig-004-20260205    gcc-8.5.0
arm                   randconfig-004-20260206    gcc-8.5.0
arm                          sp7021_defconfig    gcc-15.2.0
arm                           sunxi_defconfig    clang-22
arm                         vf610m4_defconfig    clang-22
arm                    vt8500_v6_v7_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260205    clang-22
arm64                 randconfig-001-20260205    gcc-10.5.0
arm64                 randconfig-001-20260206    gcc-13.4.0
arm64                 randconfig-002-20260205    gcc-10.5.0
arm64                 randconfig-002-20260206    gcc-13.4.0
arm64                 randconfig-003-20260205    clang-22
arm64                 randconfig-003-20260205    gcc-10.5.0
arm64                 randconfig-003-20260206    gcc-13.4.0
arm64                 randconfig-004-20260205    clang-19
arm64                 randconfig-004-20260205    gcc-10.5.0
arm64                 randconfig-004-20260206    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260205    gcc-10.5.0
csky                  randconfig-001-20260205    gcc-9.5.0
csky                  randconfig-001-20260206    gcc-13.4.0
csky                  randconfig-002-20260205    gcc-10.5.0
csky                  randconfig-002-20260206    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260205    clang-22
hexagon               randconfig-001-20260205    gcc-15.2.0
hexagon               randconfig-001-20260206    clang-22
hexagon               randconfig-002-20260205    clang-22
hexagon               randconfig-002-20260205    gcc-15.2.0
hexagon               randconfig-002-20260206    clang-22
i386                             alldefconfig    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260205    gcc-13
i386        buildonly-randconfig-001-20260205    gcc-14
i386        buildonly-randconfig-001-20260206    clang-20
i386        buildonly-randconfig-002-20260205    clang-20
i386        buildonly-randconfig-002-20260205    gcc-14
i386        buildonly-randconfig-002-20260206    clang-20
i386        buildonly-randconfig-003-20260205    clang-20
i386        buildonly-randconfig-003-20260205    gcc-14
i386        buildonly-randconfig-003-20260206    clang-20
i386        buildonly-randconfig-004-20260205    clang-20
i386        buildonly-randconfig-004-20260205    gcc-14
i386        buildonly-randconfig-004-20260206    clang-20
i386        buildonly-randconfig-005-20260205    gcc-14
i386        buildonly-randconfig-005-20260206    clang-20
i386        buildonly-randconfig-006-20260205    gcc-14
i386        buildonly-randconfig-006-20260206    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260205    gcc-13
i386                  randconfig-001-20260205    gcc-14
i386                  randconfig-001-20260206    gcc-14
i386                  randconfig-002-20260205    clang-20
i386                  randconfig-002-20260205    gcc-13
i386                  randconfig-002-20260206    gcc-14
i386                  randconfig-003-20260205    gcc-13
i386                  randconfig-003-20260206    gcc-14
i386                  randconfig-004-20260205    gcc-13
i386                  randconfig-004-20260205    gcc-14
i386                  randconfig-004-20260206    gcc-14
i386                  randconfig-005-20260205    clang-20
i386                  randconfig-005-20260205    gcc-13
i386                  randconfig-005-20260206    gcc-14
i386                  randconfig-006-20260205    gcc-13
i386                  randconfig-006-20260206    gcc-14
i386                  randconfig-007-20260205    gcc-13
i386                  randconfig-007-20260205    gcc-14
i386                  randconfig-007-20260206    gcc-14
i386                  randconfig-011-20260205    clang-20
i386                  randconfig-011-20260206    clang-20
i386                  randconfig-012-20260205    clang-20
i386                  randconfig-012-20260206    clang-20
i386                  randconfig-013-20260205    clang-20
i386                  randconfig-013-20260206    clang-20
i386                  randconfig-014-20260205    clang-20
i386                  randconfig-014-20260206    clang-20
i386                  randconfig-015-20260205    clang-20
i386                  randconfig-015-20260206    clang-20
i386                  randconfig-016-20260205    clang-20
i386                  randconfig-016-20260206    clang-20
i386                  randconfig-017-20260205    clang-20
i386                  randconfig-017-20260206    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260205    clang-22
loongarch             randconfig-001-20260205    gcc-15.2.0
loongarch             randconfig-001-20260206    clang-22
loongarch             randconfig-002-20260205    gcc-15.2.0
loongarch             randconfig-002-20260206    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-22
mips                           ip22_defconfig    clang-22
mips                        maltaup_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260205    gcc-11.5.0
nios2                 randconfig-001-20260205    gcc-15.2.0
nios2                 randconfig-001-20260206    clang-22
nios2                 randconfig-002-20260205    gcc-11.5.0
nios2                 randconfig-002-20260205    gcc-15.2.0
nios2                 randconfig-002-20260206    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    clang-22
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260205    gcc-9.5.0
parisc                randconfig-001-20260206    gcc-8.5.0
parisc                randconfig-002-20260205    gcc-9.5.0
parisc                randconfig-002-20260206    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    clang-22
powerpc                   currituck_defconfig    clang-22
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20260205    gcc-9.5.0
powerpc               randconfig-001-20260206    gcc-8.5.0
powerpc               randconfig-002-20260205    gcc-9.5.0
powerpc               randconfig-002-20260206    gcc-8.5.0
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20260205    gcc-9.5.0
powerpc64             randconfig-001-20260206    gcc-8.5.0
powerpc64             randconfig-002-20260205    gcc-9.5.0
powerpc64             randconfig-002-20260206    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260205    clang-19
riscv                 randconfig-001-20260206    clang-22
riscv                 randconfig-002-20260205    clang-19
riscv                 randconfig-002-20260205    clang-22
riscv                 randconfig-002-20260206    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260205    clang-18
s390                  randconfig-001-20260205    clang-19
s390                  randconfig-001-20260206    clang-22
s390                  randconfig-002-20260205    clang-19
s390                  randconfig-002-20260205    clang-22
s390                  randconfig-002-20260206    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260205    clang-19
sh                    randconfig-001-20260205    gcc-15.2.0
sh                    randconfig-001-20260206    clang-22
sh                    randconfig-002-20260205    clang-19
sh                    randconfig-002-20260205    gcc-10.5.0
sh                    randconfig-002-20260206    clang-22
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                            shmin_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260205    gcc-12.5.0
sparc                 randconfig-001-20260206    gcc-12.5.0
sparc                 randconfig-002-20260205    gcc-12.5.0
sparc                 randconfig-002-20260206    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260205    gcc-12.5.0
sparc64               randconfig-001-20260206    gcc-12.5.0
sparc64               randconfig-002-20260205    gcc-12.5.0
sparc64               randconfig-002-20260206    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260205    gcc-12.5.0
um                    randconfig-001-20260206    gcc-12.5.0
um                    randconfig-002-20260205    gcc-12.5.0
um                    randconfig-002-20260206    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260205    clang-20
x86_64      buildonly-randconfig-001-20260205    gcc-14
x86_64      buildonly-randconfig-001-20260206    gcc-14
x86_64      buildonly-randconfig-002-20260205    clang-20
x86_64      buildonly-randconfig-002-20260205    gcc-14
x86_64      buildonly-randconfig-002-20260206    gcc-14
x86_64      buildonly-randconfig-003-20260205    gcc-14
x86_64      buildonly-randconfig-003-20260206    gcc-14
x86_64      buildonly-randconfig-004-20260205    clang-20
x86_64      buildonly-randconfig-004-20260205    gcc-14
x86_64      buildonly-randconfig-004-20260206    gcc-14
x86_64      buildonly-randconfig-005-20260205    clang-20
x86_64      buildonly-randconfig-005-20260205    gcc-14
x86_64      buildonly-randconfig-005-20260206    gcc-14
x86_64      buildonly-randconfig-006-20260205    gcc-14
x86_64      buildonly-randconfig-006-20260206    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260205    clang-20
x86_64                randconfig-001-20260206    gcc-14
x86_64                randconfig-002-20260205    clang-20
x86_64                randconfig-002-20260206    gcc-14
x86_64                randconfig-003-20260205    clang-20
x86_64                randconfig-003-20260206    gcc-14
x86_64                randconfig-004-20260205    clang-20
x86_64                randconfig-004-20260206    gcc-14
x86_64                randconfig-005-20260205    clang-20
x86_64                randconfig-005-20260206    gcc-14
x86_64                randconfig-006-20260205    clang-20
x86_64                randconfig-006-20260206    gcc-14
x86_64                randconfig-011-20260205    clang-20
x86_64                randconfig-011-20260206    gcc-14
x86_64                randconfig-012-20260205    clang-20
x86_64                randconfig-012-20260206    gcc-14
x86_64                randconfig-013-20260205    clang-20
x86_64                randconfig-013-20260206    gcc-14
x86_64                randconfig-014-20260205    clang-20
x86_64                randconfig-014-20260206    gcc-14
x86_64                randconfig-015-20260205    clang-20
x86_64                randconfig-015-20260206    gcc-14
x86_64                randconfig-016-20260205    clang-20
x86_64                randconfig-016-20260206    gcc-14
x86_64                randconfig-071-20260205    clang-20
x86_64                randconfig-071-20260206    gcc-14
x86_64                randconfig-072-20260205    clang-20
x86_64                randconfig-072-20260206    gcc-14
x86_64                randconfig-073-20260205    clang-20
x86_64                randconfig-073-20260206    gcc-14
x86_64                randconfig-074-20260205    clang-20
x86_64                randconfig-074-20260206    gcc-14
x86_64                randconfig-075-20260205    clang-20
x86_64                randconfig-075-20260206    gcc-14
x86_64                randconfig-076-20260205    clang-20
x86_64                randconfig-076-20260206    gcc-14
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
xtensa                  cadence_csp_defconfig    clang-22
xtensa                randconfig-001-20260205    gcc-12.5.0
xtensa                randconfig-001-20260206    gcc-12.5.0
xtensa                randconfig-002-20260205    gcc-12.5.0
xtensa                randconfig-002-20260206    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

