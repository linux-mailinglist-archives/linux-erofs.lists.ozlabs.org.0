Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5885ABC3A
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Sep 2022 04:05:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MKJ646CTmz304B
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Sep 2022 12:05:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dicDfPLr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Two or more type TXT spf records found.) smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dicDfPLr;
	dkim-atps=neutral
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MKJ5y6hgPz2xGn
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Sep 2022 12:05:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662170743; x=1693706743;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oqy1H0Gn7neto3IAHbYPBEpPkwrvyz9y8k0HEwoiTA0=;
  b=dicDfPLryv4U1KlklYHfteZC/ikISfRBvZMqmY8+xHc7K6iDiQ1AXhTa
   SdVXAlbJhAsnpdTuygqO9RvThp7bPHMPXM+liBVHiDdmtLRXK1HtmnNKa
   bdYk85kWyBHGKmSwvHFfuPV2SMPvE3vivktdmoo7D+aQlnyoJVtE8j0dy
   6YlFDqkHje/Wa+pO8IyhI7RZ5qKFqvCVNTM1Ta+gNFnZX8umS/JgypVJT
   Ot1MBg3PZwOSuP6SFOgvWMI0nPVuXtkVpIjA7+mrgTT8RpVrqYQ/gNCix
   Y75utpvkGZdmh1FJXj9harH1CYG/rs4ijxtt3umYUZoJ0oso/MQJph6ge
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="294861150"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="294861150"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 19:05:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="941495654"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2022 19:05:38 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oUIXR-0000t1-2J;
	Sat, 03 Sep 2022 02:05:37 +0000
Date: Sat, 03 Sep 2022 10:05:03 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 76f9306986513ef1fd5a903c17531830adbaa5f3
Message-ID: <6312b64f.mE2Cxdgx4PtQys18%lkp@intel.com>
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
branch HEAD: 76f9306986513ef1fd5a903c17531830adbaa5f3  erofs: fix pcluster use-after-free on UP platforms

elapsed time: 1137m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a013
sh                               allmodconfig
arc                  randconfig-r043-20220901
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a016
x86_64                        randconfig-a011
i386                          randconfig-a001
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
x86_64                        randconfig-a015
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                         lubbock_defconfig
sh                           se7750_defconfig
m68k                          amiga_defconfig
powerpc                     mpc83xx_defconfig
mips                     decstation_defconfig
mips                            ar7_defconfig
powerpc                      tqm8xx_defconfig
alpha                            alldefconfig
i386                          randconfig-c001
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                            shmin_defconfig
sh                             espt_defconfig
sparc                            alldefconfig
loongarch                           defconfig
loongarch                         allnoconfig
sparc                       sparc64_defconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
arm                          pxa3xx_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
microblaze                      mmu_defconfig
powerpc                     sequoia_defconfig
openrisc                 simple_smp_defconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220902
arm                            hisi_defconfig
sh                         apsh4a3a_defconfig
powerpc                  storcenter_defconfig
powerpc                      cm5200_defconfig
mips                 randconfig-c004-20220901
arm                           stm32_defconfig
powerpc                     pq2fads_defconfig
mips                       bmips_be_defconfig
arm                          badge4_defconfig
arm                        oxnas_v6_defconfig
s390                       zfcpdump_defconfig
powerpc                     tqm8541_defconfig
sh                          r7785rp_defconfig
mips                     loongson1b_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220901
riscv                randconfig-r042-20220901
s390                 randconfig-r044-20220901
i386                          randconfig-a015
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220901
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-k001
powerpc                      walnut_defconfig
arm                       spear13xx_defconfig
mips                          ath79_defconfig
powerpc                      katmai_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
