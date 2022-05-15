Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F05278BD
	for <lists+linux-erofs@lfdr.de>; Sun, 15 May 2022 18:28:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1SVm6rQsz3bwg
	for <lists+linux-erofs@lfdr.de>; Mon, 16 May 2022 02:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Of1PAwTA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Of1PAwTA; dkim-atps=neutral
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1SVc4qHqz2yZc
 for <linux-erofs@lists.ozlabs.org>; Mon, 16 May 2022 02:28:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652632104; x=1684168104;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=c27LdTfqS3jLzI5xmFGuMfxc2FT0TTaav5p+44m42cc=;
 b=Of1PAwTAmIi0CCn05Cr71H/yNqY/6b1vxpMNrQYq3XJ9znpjmPz/eZAI
 2i+32hxfSKxPK5jFNaNXHpnkBTCADDo0c2ngNlasqb3B7QPkADXluUFXK
 EEfFjYveTqeB0jQQiTcO/A6j+9OdOR81l9Y+mj9VsXkgbuSrW8RjW9EUe
 AyP5+CESr4ttYjf7/FVT6RQiU6cttKGDrFHHPusVmB4+iNkeIKowf/NKP
 8YImqkJ3amINzVnEPNoPuYOJzbqF0t6QZ+cuxr0CBKpPZ1znNogZUYPZ5
 FYenZROnqgh/xflftFsGMFXfNRLGbJxu0ofrTtSdF5w80aNsdU8imCaJn w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="295909049"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; d="scan'208";a="295909049"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2022 09:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; d="scan'208";a="554960990"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 15 May 2022 09:27:12 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nqH5L-0001nq-Jq;
 Sun, 15 May 2022 16:27:11 +0000
Date: Mon, 16 May 2022 00:26:16 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 34f78be468b9e9f951caad31b098871530a5bb56
Message-ID: <628129a8./m5YubJIiMaQTphd%lkp@intel.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 34f78be468b9e9f951caad31b098871530a5bb56  erofs: scan devices from device table

elapsed time: 3311m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220512
i386                          randconfig-c001
x86_64                              defconfig
mips                         tb0226_defconfig
arm                           stm32_defconfig
um                               alldefconfig
xtensa                    xip_kc705_defconfig
xtensa                generic_kc705_defconfig
parisc                generic-64bit_defconfig
arm                        trizeps4_defconfig
sh                          r7785rp_defconfig
powerpc                      makalu_defconfig
arm                         axm55xx_defconfig
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
arm                             ezx_defconfig
sh                          lboxre2_defconfig
powerpc                     taishan_defconfig
sparc                       sparc32_defconfig
arc                           tb10x_defconfig
xtensa                  cadence_csp_defconfig
h8300                     edosk2674_defconfig
sh                        sh7763rdp_defconfig
powerpc                           allnoconfig
powerpc                 mpc837x_mds_defconfig
powerpc                  iss476-smp_defconfig
mips                       capcella_defconfig
arm                     eseries_pxa_defconfig
arm                        cerfcube_defconfig
mips                           gcw0_defconfig
parisc                generic-32bit_defconfig
sh                            hp6xx_defconfig
sh                           se7751_defconfig
sh                          rsk7264_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
arm                          collie_defconfig
powerpc                 mpc8272_ads_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm8540_defconfig
riscv                             allnoconfig
powerpc                        fsp2_defconfig
arm                          moxart_defconfig
mips                           ip22_defconfig
powerpc                      ppc64e_defconfig
x86_64                           allyesconfig
arm                      pxa255-idp_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   lite5200b_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      ppc44x_defconfig
mips                      pic32mzda_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
