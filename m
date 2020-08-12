Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4665B2425DF
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Aug 2020 09:14:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRLYl4NFSzDqXQ
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Aug 2020 17:14:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BRLYW0wVgzDqWX
 for <linux-erofs@lists.ozlabs.org>; Wed, 12 Aug 2020 17:14:37 +1000 (AEST)
IronPort-SDR: YnlSjLAcDrqrrvVgOmLNYN9iv7exeoQCQlkcvOf+L/iQOII49gtTyumWw8s3DRBmdNY9JMw+rx
 cM83S3Yh/mUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="151563309"
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; d="scan'208";a="151563309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 00:14:33 -0700
IronPort-SDR: fKFf3/QMUHDYqHqLbdZpFEZzimk4iVYXM505zKlKVr96xdU4y4t7becxARvu3xfLg8tOgLc7pX
 PSLUSKkSVEgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; d="scan'208";a="277777324"
Received: from lkp-server01.sh.intel.com (HELO e03a785590b8) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2020 00:14:32 -0700
Received: from kbuild by e03a785590b8 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1k5kxz-0000BR-H5; Wed, 12 Aug 2020 07:14:31 +0000
Date: Wed, 12 Aug 2020 15:13:44 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 1ae26ffb3572fa84769daa9a3837bcb83be89888
Message-ID: <5f3396a8.NFhPMsM9AbSaGreM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev-test
branch HEAD: 1ae26ffb3572fa84769daa9a3837bcb83be89888  erofs: avoid duplicated permission check for "trusted." xattrs

elapsed time: 722m

configs tested: 94
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allyesconfig
arm                            xcep_defconfig
mips                          ath25_defconfig
sh                           se7619_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arm                         axm55xx_defconfig
powerpc                     ep8248e_defconfig
arc                        nsim_700_defconfig
arm                            hisi_defconfig
arm                  colibri_pxa270_defconfig
sh                          rsk7264_defconfig
arm                            mmp2_defconfig
xtensa                              defconfig
arm                        clps711x_defconfig
s390                             allyesconfig
arm                         lubbock_defconfig
arm                          badge4_defconfig
mips                      maltaaprp_defconfig
arm                          pxa3xx_defconfig
sh                         microdev_defconfig
powerpc                      ppc44x_defconfig
arm                       mainstone_defconfig
sh                            shmin_defconfig
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
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200811
x86_64               randconfig-a001-20200811
x86_64               randconfig-a003-20200811
x86_64               randconfig-a005-20200811
x86_64               randconfig-a004-20200811
x86_64               randconfig-a002-20200811
i386                 randconfig-a005-20200811
i386                 randconfig-a001-20200811
i386                 randconfig-a002-20200811
i386                 randconfig-a003-20200811
i386                 randconfig-a006-20200811
i386                 randconfig-a004-20200811
i386                 randconfig-a016-20200811
i386                 randconfig-a011-20200811
i386                 randconfig-a015-20200811
i386                 randconfig-a013-20200811
i386                 randconfig-a012-20200811
i386                 randconfig-a014-20200811
i386                 randconfig-a016-20200812
i386                 randconfig-a011-20200812
i386                 randconfig-a013-20200812
i386                 randconfig-a015-20200812
i386                 randconfig-a012-20200812
i386                 randconfig-a014-20200812
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
