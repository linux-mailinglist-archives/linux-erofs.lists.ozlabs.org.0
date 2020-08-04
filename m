Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A823B22D
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Aug 2020 03:18:09 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLH1p6gs7zDqWQ
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Aug 2020 11:18:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLH1j70JtzDqQT
 for <linux-erofs@lists.ozlabs.org>; Tue,  4 Aug 2020 11:18:00 +1000 (AEST)
IronPort-SDR: 2OFgQjg7UOsF4FWiiO/K6PaZsI/fzePzhx0u1mj6PQ8ltzN/sxLkFG4l3XTU5L7/U8cyhFWXpj
 WGYL9zozL8lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="149678494"
X-IronPort-AV: E=Sophos;i="5.75,432,1589266800"; d="scan'208";a="149678494"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 18:17:56 -0700
IronPort-SDR: MgbKNs79gqnA1DFWw0o0AOUeXH4UsVHRzH2SC6UcEfUHyExC5KH2FUAWXaPvxuOZBi2X4swMmI
 4zKA9tPBkTmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,432,1589266800"; d="scan'208";a="332296674"
Received: from lkp-server02.sh.intel.com (HELO 84ccfe698a63) ([10.239.97.151])
 by orsmga007.jf.intel.com with ESMTP; 03 Aug 2020 18:17:54 -0700
Received: from kbuild by 84ccfe698a63 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1k2laU-0000LL-3P; Tue, 04 Aug 2020 01:17:54 +0000
Date: Tue, 04 Aug 2020 09:17:10 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 0e62ea33ac12ebde876b67eca113630805191a66
Message-ID: <5f28b716.DGwZ+U2ekWBRgbWn%lkp@intel.com>
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
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev
branch HEAD: 0e62ea33ac12ebde876b67eca113630805191a66  erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's

elapsed time: 724m

configs tested: 95
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
ia64                        generic_defconfig
m68k                       bvme6000_defconfig
arm                          pxa168_defconfig
powerpc                       maple_defconfig
mips                malta_qemu_32r6_defconfig
arm64                            alldefconfig
arm                    vt8500_v6_v7_defconfig
arm                            lart_defconfig
mips                        omega2p_defconfig
mips                     loongson1c_defconfig
xtensa                           alldefconfig
arm                             pxa_defconfig
sh                             sh03_defconfig
powerpc64                           defconfig
mips                         db1xxx_defconfig
sparc                               defconfig
arm                        trizeps4_defconfig
parisc                           alldefconfig
mips                           ip32_defconfig
h8300                       h8s-sim_defconfig
arm                        spear6xx_defconfig
mips                          rb532_defconfig
powerpc                     mpc83xx_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200803
i386                 randconfig-a005-20200803
i386                 randconfig-a001-20200803
i386                 randconfig-a002-20200803
i386                 randconfig-a003-20200803
i386                 randconfig-a006-20200803
x86_64               randconfig-a016-20200803
x86_64               randconfig-a015-20200803
x86_64               randconfig-a013-20200803
x86_64               randconfig-a011-20200803
x86_64               randconfig-a012-20200803
x86_64               randconfig-a014-20200803
i386                 randconfig-a011-20200803
i386                 randconfig-a012-20200803
i386                 randconfig-a015-20200803
i386                 randconfig-a014-20200803
i386                 randconfig-a013-20200803
i386                 randconfig-a016-20200803
x86_64               randconfig-a006-20200804
x86_64               randconfig-a001-20200804
x86_64               randconfig-a004-20200804
x86_64               randconfig-a005-20200804
x86_64               randconfig-a002-20200804
x86_64               randconfig-a003-20200804
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
