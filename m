Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032335ADE48
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 06:03:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MMBZM6mpzz3042
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 14:03:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wdng61nu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Two or more type TXT spf records found.) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wdng61nu;
	dkim-atps=neutral
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MMBZG6Rh4z2xbC
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Sep 2022 14:03:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662436999; x=1693972999;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TDFuNsuwOMC6+wLQ6W3tYi0xCxrpU0AMU4jdJA/I9DE=;
  b=Wdng61nuzQZeCBfQT1EXHL5ke35PU3T3/52mkJtzUBUOFyhz1mY5RZ5I
   zc+uBbhHlzzco0le0rS+GuUoDCYhG2lfzJiv3uhaVDlUQTSpZsY+3CFiE
   ZnsMqLYvEhlfhBKn3Whn0SJax8GGxMvVsWTJsA7rOxAno65dr6ugcm+jD
   GLm7fg948S3sYT6hGqxb/rKz48rdvzf9rkbHyffYVqQlaSvPWeAf4UZ8B
   1afj9otrRZ9AZQszccWaaVQJWiah5kCeS7TbJD3gjhQ/20BgW+DY/qCsl
   vIyQ696CvWU+z1HXemnhNcqkDjXCzfiek5LElA3xPSJpDAyGAYs8yFx9+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="358212885"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="358212885"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 21:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="942302910"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 21:03:08 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oVPno-0004nI-0d;
	Tue, 06 Sep 2022 04:03:08 +0000
Date: Tue, 06 Sep 2022 12:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 2f44013e39984c127c6efedf70e6b5f4e9dcf315
Message-ID: <6316c66c.y6wndPTPrGgrFQdS%lkp@intel.com>
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
branch HEAD: 2f44013e39984c127c6efedf70e6b5f4e9dcf315  erofs: fix pcluster use-after-free on UP platforms

elapsed time: 720m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
i386                 randconfig-a001-20220905
i386                 randconfig-a002-20220905
x86_64                               rhel-8.3
i386                             allyesconfig
i386                 randconfig-a005-20220905
powerpc                          allmodconfig
mips                             allyesconfig
i386                 randconfig-a003-20220905
i386                 randconfig-a006-20220905
powerpc                           allnoconfig
sh                               allmodconfig
i386                 randconfig-a004-20220905
arm                                 defconfig
x86_64               randconfig-a003-20220905
x86_64               randconfig-a002-20220905
x86_64               randconfig-a004-20220905
x86_64               randconfig-a005-20220905
x86_64               randconfig-a001-20220905
arm64                            allyesconfig
x86_64               randconfig-a006-20220905
arm                              allyesconfig
arc                  randconfig-r043-20220905
m68k                             allmodconfig
arc                  randconfig-r043-20220906
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
riscv                randconfig-r042-20220906
s390                 randconfig-r044-20220906
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig

clang tested configs:
x86_64               randconfig-a012-20220905
x86_64               randconfig-a011-20220905
i386                 randconfig-a013-20220905
x86_64               randconfig-a013-20220905
i386                 randconfig-a012-20220905
i386                 randconfig-a011-20220905
i386                 randconfig-a014-20220905
x86_64               randconfig-a016-20220905
s390                 randconfig-r044-20220905
i386                 randconfig-a015-20220905
x86_64               randconfig-a014-20220905
hexagon              randconfig-r041-20220906
i386                 randconfig-a016-20220905
x86_64               randconfig-a015-20220905
hexagon              randconfig-r045-20220906
hexagon              randconfig-r045-20220905
arm                       cns3420vb_defconfig
riscv                randconfig-r042-20220905
hexagon              randconfig-r041-20220905

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
