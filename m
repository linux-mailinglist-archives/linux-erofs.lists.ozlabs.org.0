Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BFC59558F
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Aug 2022 10:48:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M6PtT2xdzz3bZC
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Aug 2022 18:48:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ebl/Rg4B;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ebl/Rg4B;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M6PtP2jf4z2xrD
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Aug 2022 18:47:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660639677; x=1692175677;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rqSjSVGUDfo8AFEjc9tJNJ2bq/41tgmf48O+t92mo6M=;
  b=Ebl/Rg4BHJzPTWfkqpgTuddIVlSuQh7hrGu1/X6q/PHkMMdiEarputfk
   Gy0Yt3mGu8mQ+BLv+0+TPeUb4m6EtDd6kCGQwzEY4scv081Fkx4HUEHx9
   wKgKQwdT5m+ztPrvKnvznXImx+gaGRoIiiLbDKs94p88tZXDVY1JKaHpS
   4BVH4ZfbCRBKFUOXEhkgmJk6C7qDQc8iykB/TDqHQQunFELT0tw49GRNO
   2SJiGCpOM2ydb5I4v9MXgNIqxjdF7D6C6+8YYSJ2lQHSDmVFA18FPc0iL
   DuE2/QcSqeecfJ0Iz9nMFOHqZxVxZdynMmSui5LLa64GngR26ztHfSUFA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292161986"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292161986"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:47:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="639953161"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2022 01:47:51 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oNsEo-0001eH-2o;
	Tue, 16 Aug 2022 08:47:50 +0000
Date: Tue, 16 Aug 2022 16:47:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 c0814d3618feeffbf00a0b7e0393f5b4cdf7afc2
Message-ID: <62fb59a9.clEUyXdw4cJKZKDk%lkp@intel.com>
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
branch HEAD: c0814d3618feeffbf00a0b7e0393f5b4cdf7afc2  erofs: avoid the potentially wrong m_plen for big pcluster

elapsed time: 705m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220815
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a001-20220815
i386                 randconfig-a005-20220815
i386                 randconfig-a004-20220815
i386                 randconfig-a006-20220815
i386                 randconfig-a003-20220815
i386                 randconfig-a002-20220815
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
i386                                defconfig
arm                      integrator_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
x86_64               randconfig-a006-20220815
x86_64               randconfig-a003-20220815
x86_64               randconfig-a005-20220815
x86_64               randconfig-a004-20220815
x86_64               randconfig-a001-20220815
x86_64               randconfig-a002-20220815
mips                         bigsur_defconfig
powerpc                      chrp32_defconfig
arm                           h3600_defconfig
i386                 randconfig-c001-20220815
sh                            hp6xx_defconfig
powerpc                   currituck_defconfig
ia64                             allmodconfig
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig
arm                      footbridge_defconfig
powerpc                     stx_gp3_defconfig
nios2                               defconfig
arm                         vf610m4_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc              randconfig-c003-20220815
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                            q40_defconfig
arm                         s3c6400_defconfig
powerpc                      makalu_defconfig
arc                            hsdk_defconfig
powerpc                    klondike_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                         virt_defconfig
powerpc                       eiger_defconfig
arm                          iop32x_defconfig
m68k                       m5208evb_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig

clang tested configs:
hexagon              randconfig-r045-20220815
hexagon              randconfig-r041-20220815
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a012-20220815
x86_64               randconfig-a011-20220815
x86_64               randconfig-a016-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a016-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a013-20220815
arm                        multi_v5_defconfig
x86_64               randconfig-k001-20220815
powerpc                          g5_defconfig
powerpc                          allmodconfig
powerpc                 mpc836x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
