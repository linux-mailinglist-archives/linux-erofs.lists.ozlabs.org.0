Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CE66AF3F
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Jan 2023 05:07:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NvhT61NVqz3cCD
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Jan 2023 15:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c9CqQTay;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c9CqQTay;
	dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NvhSw6Yn9z3bZk
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Jan 2023 15:07:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673755665; x=1705291665;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JdemynD+uzkBIvedvNguIDSCVGWNgG4r294yGUniO+U=;
  b=c9CqQTayuYVBakrrCZJb/v8UY+eKeHLrrVZcvB5mLifgqkT43YDe9H/M
   j7TeTkKpKbc5SWBVSeWo1oNrE880gx8IIU4ddyV0mGajkRTjzXS0WFT1b
   s8HGlB9vObnNZFqEqji6lBEwQEf/cVKdfvniATMng6T8yvBZnvr+9Dv4W
   WQCygAAYHsV7iNFGOYjzwAGqYtEo6wxIwOaUNPWSDykkhoL68lfIN9ITU
   YAefz5UFiuzWda6kD50qrHrwWTwx6/9EdJ/1qlXGb9xQk40U+PUilmX6n
   ig1MgmHQsDjmKK43/IN52O7JdYV0ebl8SIT625eZBZp2ircwR7aHNo5bL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="326321666"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="326321666"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 20:07:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="636175834"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="636175834"
Received: from lkp-server01.sh.intel.com (HELO 82361ecceba2) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2023 20:07:32 -0800
Received: from kbuild by 82361ecceba2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pGuIu-00002q-2u;
	Sun, 15 Jan 2023 04:07:32 +0000
Date: Sun, 15 Jan 2023 12:06:53 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 7235d5407279761d49ccf5c8adcbaea958f3e2da
Message-ID: <63c37bdd.6k7EQWsqz1HaLqMO%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 7235d5407279761d49ccf5c8adcbaea958f3e2da  erofs: simplify iloc()

elapsed time: 721m

configs tested: 118
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                              allnoconfig
alpha                             allnoconfig
arm                               allnoconfig
arc                               allnoconfig
arm                                 defconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a001
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
arc                                 defconfig
i386                          randconfig-a003
i386                          randconfig-a014
s390                             allmodconfig
x86_64                        randconfig-a002
x86_64                              defconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
alpha                               defconfig
x86_64                           rhel-8.3-bpf
s390                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
s390                             allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                                  defconfig
arm                           h3600_defconfig
sh                           se7712_defconfig
powerpc                       eiger_defconfig
powerpc                    sam440ep_defconfig
s390                          debug_defconfig
sparc64                          alldefconfig
sh                          rsk7201_defconfig
mips                         bigsur_defconfig
sh                             shx3_defconfig
sh                            hp6xx_defconfig
arm                        multi_v7_defconfig
sh                ecovec24-romimage_defconfig
mips                           ci20_defconfig
i386                          randconfig-c001
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
m68k                          hp300_defconfig
sh                               j2_defconfig
mips                            ar7_defconfig
powerpc                 canyonlands_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          r7785rp_defconfig
sh                        dreamcast_defconfig
sh                             espt_defconfig
mips                      maltasmvp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                                defconfig
i386                             allyesconfig
arm                             pxa_defconfig
powerpc                    adder875_defconfig
sh                               alldefconfig
arm                        realview_defconfig
arm                        spear6xx_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arc                        nsim_700_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                    xip_kc705_defconfig
sh                              ul2_defconfig
sh                          rsk7203_defconfig
m68k                                defconfig
sh                        edosk7760_defconfig
sparc                            allyesconfig
sh                        sh7757lcr_defconfig
arm                            hisi_defconfig
powerpc                       maple_defconfig
mips                           xway_defconfig
openrisc                    or1ksim_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a011
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a005
powerpc                 mpc8560_ads_defconfig
powerpc                     mpc5200_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-k001
arm                          moxart_defconfig
x86_64                          rhel-8.3-rust
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
powerpc                 mpc836x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
