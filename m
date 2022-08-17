Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941B5969AA
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 08:42:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M6z3612vBz3bkn
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 16:42:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IgSDljDD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IgSDljDD;
	dkim-atps=neutral
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M6z322jzHz2xKh
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Aug 2022 16:42:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660718542; x=1692254542;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=i4C9mDr986PJa69IN2JxYegWGHt7akkasLTphOgNWsQ=;
  b=IgSDljDDCWO9eRbEVvOXUU8zF1/sS7yaStKEi9Kis7XzsHTGh34PprQG
   wwxH3NIME2d0AYF0qhMdfA4BOsFNgzaXfMcCdCW2bcPNWW6qGrWaOYisC
   obakcNqQnBd9KP9CPml3pZMv5wPlHL5kI4VZNM5vznRWlwafNLg2oHSG7
   EHoHdUdCHl+/uwF05X92MpjrqMryBFKZH7zbk7S4Z+KkvGJ9H86cOKJRl
   9bfIOHQLrFZd9Y4bWMFjaWPBcPHgCO/71voBMTSsUKV7ZJWbGRX/hrulq
   7XaMPAXYVGJum06fxYV16e1xdWKRS20arD9ho2KFNAW0zRK3RKxfRmPeE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378709136"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378709136"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 23:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="636239466"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2022 23:42:13 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oOCkm-0000ea-18;
	Wed, 17 Aug 2022 06:42:12 +0000
Date: Wed, 17 Aug 2022 14:41:30 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 0d53d2e882f9ee1857c4177314e6a376a5311c26
Message-ID: <62fc8d9a.IlWttttghjUUUlz4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 0d53d2e882f9ee1857c4177314e6a376a5311c26  erofs: avoid the potentially wrong m_plen for big pcluster

elapsed time: 725m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                              allyesconfig
alpha                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-a001-20220815
x86_64               randconfig-a003-20220815
arm                                 defconfig
m68k                             allmodconfig
i386                                defconfig
sh                               allmodconfig
x86_64               randconfig-a005-20220815
x86_64               randconfig-a004-20220815
powerpc                          allmodconfig
x86_64               randconfig-a002-20220815
x86_64                        randconfig-a004
i386                 randconfig-a003-20220815
m68k                             allyesconfig
x86_64                        randconfig-a002
i386                 randconfig-a005-20220815
mips                             allyesconfig
i386                 randconfig-a002-20220815
i386                 randconfig-a006-20220815
i386                 randconfig-a001-20220815
powerpc                           allnoconfig
arc                  randconfig-r043-20220815
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64               randconfig-a006-20220815
x86_64                          rhel-8.3-func
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a004-20220815
x86_64                              defconfig
x86_64                           allyesconfig
arm64                            allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                        nsimosci_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
arm                         lubbock_defconfig
csky                                defconfig
arm                         vf610m4_defconfig
powerpc              randconfig-c003-20220815
i386                 randconfig-c001-20220815
m68k                          atari_defconfig
powerpc                      cm5200_defconfig
ia64                            zx1_defconfig
powerpc                         wii_defconfig
sh                          landisk_defconfig
parisc64                         alldefconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
ia64                         bigsur_defconfig
xtensa                  cadence_csp_defconfig
ia64                        generic_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     mpc83xx_defconfig
arm                          pxa910_defconfig
sh                                  defconfig
ia64                      gensparse_defconfig
ia64                                defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                  audio_kc705_defconfig
um                                  defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
arm                      footbridge_defconfig
m68k                        m5407c3_defconfig
sparc                       sparc32_defconfig
m68k                       m5275evb_defconfig
sh                   sh7770_generic_defconfig
parisc                           allyesconfig
arm                        cerfcube_defconfig
arc                     haps_hs_smp_defconfig
parisc                              defconfig
nios2                         3c120_defconfig
m68k                        stmark2_defconfig
sh                           se7343_defconfig
m68k                                defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
powerpc                     ep8248e_defconfig
powerpc                  iss476-smp_defconfig
mips                         cobalt_defconfig
m68k                            mac_defconfig

clang tested configs:
hexagon              randconfig-r045-20220815
riscv                randconfig-r042-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a016-20220815
hexagon              randconfig-r041-20220815
i386                 randconfig-a015-20220815
x86_64               randconfig-a012-20220815
x86_64                        randconfig-a001
x86_64               randconfig-a011-20220815
x86_64                        randconfig-a003
s390                 randconfig-r044-20220815
x86_64                        randconfig-a005
x86_64               randconfig-a015-20220815
i386                 randconfig-a016-20220815
x86_64               randconfig-a014-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a013-20220815
i386                 randconfig-a014-20220815
mips                          ath79_defconfig
x86_64               randconfig-k001-20220815

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
