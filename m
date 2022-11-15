Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D58629120
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 05:12:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NBCSC4yFZz3cGk
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 15:12:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TSvBHlsZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TSvBHlsZ;
	dkim-atps=neutral
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NBCS70xB2z3c6k
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Nov 2022 15:12:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668485527; x=1700021527;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GwJ3RDka3zAGG2KZIgdjo7VZkjUW0rdXF6574g4YLXQ=;
  b=TSvBHlsZNRxhYyAsH86MKFkkNfv7i53mbka/Kyia98JQz3wFXWzJjqho
   GH9mKuJzSjWHL11dw961y/XHU4+JC0ZCkTmFXRhIaoynIUGJ1fqsFV0Cd
   svnGudAcfe8g6iEmNqeKt/fOiWK8MXnY2s6EnnpW4SRc0BWl6fkY7CweF
   bkW/VZlIrGsmIgbmbhcIW4KmJOzCgmRXWdsaMQ+/2CyrkAuf2RYoGv6lt
   MD/HqAjBMsndWXXg0smQGJCn7U8dA4E+IdNhSQA5yZuKUmMhQLoumQuPK
   AVvmnXE8N2rnUwRAWMONINI4iWNArEr1tA1ZXXxRt1wvBnZzvGXbu+JaJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299678079"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="299678079"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 20:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="641046688"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="641046688"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Nov 2022 20:11:54 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ounIf-00011o-2n;
	Tue, 15 Nov 2022 04:11:53 +0000
Date: Tue, 15 Nov 2022 12:11:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 37020bbb71d911431e16c2c940b97cf86ae4f2f6
Message-ID: <6373117b.QmLvMohvv8mM22VC%lkp@intel.com>
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
branch HEAD: 37020bbb71d911431e16c2c940b97cf86ae4f2f6  erofs: fix missing xas_retry() in fscache mode

elapsed time: 721m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
i386                              allnoconfig
arc                               allnoconfig
arm                               allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
mips                             allyesconfig
sh                               allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221114
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
m68k                             allyesconfig
s390                                defconfig
alpha                            allyesconfig
x86_64                              defconfig
arc                              allyesconfig
i386                                defconfig
s390                 randconfig-r044-20221115
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allmodconfig
s390                             allyesconfig
i386                             allyesconfig
x86_64               randconfig-a002-20221114
x86_64               randconfig-a001-20221114
x86_64               randconfig-a003-20221114
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                 randconfig-a006-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a002-20221114
i386                 randconfig-a003-20221114
x86_64               randconfig-a005-20221114
ia64                             allmodconfig
i386                 randconfig-a001-20221114
x86_64               randconfig-a004-20221114
x86_64               randconfig-a006-20221114
i386                 randconfig-a005-20221114
x86_64                            allnoconfig
arm                                 defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
sh                            hp6xx_defconfig
mips                  decstation_64_defconfig
powerpc                    sam440ep_defconfig
sparc64                          alldefconfig
i386                 randconfig-c001-20221114
sparc64                             defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
parisc                generic-32bit_defconfig
sh                     magicpanelr2_defconfig
mips                           gcw0_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20221114
hexagon              randconfig-r045-20221114
x86_64               randconfig-a012-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a011-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a015-20221114
x86_64               randconfig-k001-20221114
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
arm                        magician_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a015-20221114
i386                 randconfig-a013-20221114
i386                 randconfig-a011-20221114
i386                 randconfig-a016-20221114
i386                 randconfig-a012-20221114
i386                 randconfig-a014-20221114
arm                      pxa255-idp_defconfig
arm                       versatile_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
