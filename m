Return-Path: <linux-erofs+bounces-3120-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPY7Iq2Zymmg+QUAu9opvQ
	(envelope-from <linux-erofs+bounces-3120-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 17:41:33 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D96AB35E122
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 17:41:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkwTN6tzCz2xlt;
	Tue, 31 Mar 2026 02:41:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774885288;
	cv=none; b=aJieSokKIfk0/p1JyRibde8yzqdS0w9IIkmXsRdO1wFT9Ncr1dvc5DyszO1CTU49qXqyZjaMU/VJna/bk9N/t7OwIIfFU4twoSYIVo+WxFVKFEpRaT1W7PBUhUT5bc/4or/A+tqSkjaEb2E8dvyWRPHofmlFYy8yfjQsnCAZ3a653NkksgT/7mT/+XfP/BEfSxWWUAMkHKtb/PmCM1zU8/P9WOmoQPp7AYyReRvbY2pOCcv6qBEBvcVCb3pnLg9jxS85zHmNlZurDUq3GweMX3KbkFxmUmDzlP0jqaIZiF6O2lad6W1M7kdVW0BVGE3P6UpCAeBGx18rm1TglegUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774885288; c=relaxed/relaxed;
	bh=5Cy1QUVN6JKKLoC/RTPK9ngdVaYO9Nu3HYe8Lg/WXjE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BLSvNzPspIaOc+VUteiwyq+pcdyWkGVz//QOgL0lmOj83qtCyTSootoB+82zm55LDXQd5OsIO+hcz3KmW7eHmDeEffumSqkBWwZoiIAgj6IzijgOvRS4LLs3FOAMmHVfifYOAxNMJdSpiV0rhQMxF27hD9FEVMfsLE0vofP6GDIrgDGVPMcdqlo8F2+idKU1BA6mX1VeqXR3UBjRAee+2IvaSDm5ANJHOP5q4SkbfboZ8nZxI3VacoaDnW1KPQq5Dw7NVVp/MEWSjhVrCbZyCVqXvducqyECE8rad24Ybx4WuyLCIbehFxgqNIY7ypS/OUSwTNa3QJT8IZpoNhCg5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mLuXoszB; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mLuXoszB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkwTL45drz2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 02:41:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774885287; x=1806421287;
  h=date:from:to:cc:subject:message-id;
  bh=kTyh+6b930tFThXysF4TJGKHACLGCMO3kn1iG+uWPHc=;
  b=mLuXoszBz9WxFQ2OCRJ6VFZR7N//J8lKreYodSdLHpLMTKvoQxoCh9ve
   GgNU83TYJSd+JjVc968nqx5DGrWpUqVw/Jd8+3g/UFMCz8LRkkUDnNgKk
   N3nnkFZbLi6C9DIPxEuWHU7rYclz+D4CFa07Uq3jcUrMoqIY/I2d6/UMO
   rS+d02TW87HBIyvP9nouel1Ra03c3eTFMnR5wi9NXFaiSMAWbHUI7svwM
   VRypqU7KW9dZNDQ59uGW1wJOc0bNpCI7ggCTrUz/MBYuhUn+OMM93gj8o
   y6M++wV8k29hvY1UK7fuJVhBIMzkXWRM31qm1SvUCHaWXYps51DeQboFp
   Q==;
X-CSE-ConnectionGUID: 7qi5Q0dtR2ensfnzt7KFGw==
X-CSE-MsgGUID: cO1hNeoRSzOV8ESRPVG+hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86574614"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="86574614"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 08:41:22 -0700
X-CSE-ConnectionGUID: 6u5mPgh7QtKBUKxo1MIpsQ==
X-CSE-MsgGUID: p+CcjaUYSNOZiESRuYdXRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="225100982"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Mar 2026 08:41:20 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7Ejt-000000001HF-0INJ;
	Mon, 30 Mar 2026 15:41:17 +0000
Date: Mon, 30 Mar 2026 23:40:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS WITH UNVERIFIED WARNING
 eabeee4332ac9b5d87ab602f845dbf0e9f854978
Message-ID: <202603302329.Tt4F1wdm-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-3120-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D96AB35E122
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: eabeee4332ac9b5d87ab602f845dbf0e9f854978  erofs: verify metadata accesses for file-backed mounts

Unverified Warning (likely false positive, kindly check if interested):

    fs/erofs/data.c:45 erofs_bread() warn: passing positive error code '(-4095)-(-1),1-4096' to 'ERR_PTR'

Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-r073-20260330
|   `-- fs-erofs-data.c-erofs_bread()-warn:passing-positive-error-code-to-ERR_PTR
`-- i386-randconfig-141-20260330
    `-- fs-erofs-data.c-erofs_bread()-warn:passing-positive-error-code-to-ERR_PTR

elapsed time: 764m

configs tested: 161
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260330    gcc-8.5.0
arc                   randconfig-002-20260330    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260330    gcc-14.3.0
arm                   randconfig-002-20260330    clang-23
arm                   randconfig-003-20260330    clang-23
arm                   randconfig-004-20260330    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260330    clang-23
arm64                 randconfig-002-20260330    clang-23
arm64                 randconfig-003-20260330    gcc-8.5.0
arm64                 randconfig-004-20260330    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260330    gcc-14.3.0
csky                  randconfig-002-20260330    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260330    clang-23
hexagon               randconfig-002-20260330    clang-19
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260330    clang-20
i386        buildonly-randconfig-002-20260330    clang-20
i386        buildonly-randconfig-003-20260330    clang-20
i386        buildonly-randconfig-004-20260330    gcc-14
i386        buildonly-randconfig-005-20260330    clang-20
i386        buildonly-randconfig-006-20260330    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260330    clang-20
i386                  randconfig-002-20260330    clang-20
i386                  randconfig-003-20260330    clang-20
i386                  randconfig-004-20260330    clang-20
i386                  randconfig-005-20260330    clang-20
i386                  randconfig-006-20260330    gcc-14
i386                  randconfig-007-20260330    clang-20
i386                  randconfig-011-20260330    gcc-14
i386                  randconfig-012-20260330    gcc-14
i386                  randconfig-013-20260330    gcc-14
i386                  randconfig-014-20260330    gcc-14
i386                  randconfig-015-20260330    gcc-14
i386                  randconfig-016-20260330    gcc-14
i386                  randconfig-017-20260330    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260330    clang-23
loongarch             randconfig-002-20260330    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260330    gcc-11.5.0
nios2                 randconfig-002-20260330    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260330    gcc-8.5.0
parisc                randconfig-002-20260330    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260330    gcc-8.5.0
powerpc               randconfig-002-20260330    clang-23
powerpc64             randconfig-001-20260330    gcc-8.5.0
powerpc64             randconfig-002-20260330    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260330    clang-23
riscv                 randconfig-002-20260330    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260330    gcc-15.2.0
s390                  randconfig-002-20260330    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260330    gcc-15.2.0
sh                    randconfig-002-20260330    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260330    gcc-11.5.0
sparc                 randconfig-002-20260330    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260330    clang-20
sparc64               randconfig-002-20260330    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260330    gcc-14
um                    randconfig-002-20260330    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260330    clang-20
x86_64      buildonly-randconfig-002-20260330    gcc-14
x86_64      buildonly-randconfig-003-20260330    gcc-13
x86_64      buildonly-randconfig-004-20260330    gcc-14
x86_64      buildonly-randconfig-005-20260330    clang-20
x86_64      buildonly-randconfig-006-20260330    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260330    gcc-14
x86_64                randconfig-002-20260330    clang-20
x86_64                randconfig-003-20260330    clang-20
x86_64                randconfig-004-20260330    clang-20
x86_64                randconfig-005-20260330    gcc-14
x86_64                randconfig-006-20260330    clang-20
x86_64                randconfig-011-20260330    gcc-14
x86_64                randconfig-012-20260330    gcc-14
x86_64                randconfig-013-20260330    gcc-14
x86_64                randconfig-014-20260330    clang-20
x86_64                randconfig-015-20260330    clang-20
x86_64                randconfig-016-20260330    gcc-14
x86_64                randconfig-071-20260330    clang-20
x86_64                randconfig-072-20260330    gcc-14
x86_64                randconfig-073-20260330    clang-20
x86_64                randconfig-074-20260330    clang-20
x86_64                randconfig-075-20260330    clang-20
x86_64                randconfig-076-20260330    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260330    gcc-8.5.0
xtensa                randconfig-002-20260330    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

