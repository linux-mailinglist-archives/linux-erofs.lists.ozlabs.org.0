Return-Path: <linux-erofs+bounces-116-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B2A6CD39
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Mar 2025 00:27:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKwT15Hbgz2ygk;
	Sun, 23 Mar 2025 10:27:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742686037;
	cv=none; b=Ws2BFqlxQrHOkEvrJzO5SZ3LGFuq9iwfWBl3IcX9JxvwrOVhiwSOxGQjzIA0trOc8upE1ucrWFg1RgcLIxm5FeWnyfsGdn/UuK+G37X4OArMNY2tz9P/e9j3eO1YMOD+nL0OMyrkfq938X5TQDUiBTXfs09WgRCMkrP95QuJDBE/cbj6fQ43EYwXmBhvgbOJ2isaeEG7T8MzG/h61zN3iwGHPpImtMvZnKX+KccYuRxeBQWDkSY3HBV4yDuqaawZf5+FWGeiwoYPqn01fevYZ0PFa4DuhdVBP9Eq+HM129ClR8DbWGUwySeyD6JXXTCWcpWOautcGQzeGS68QvsF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742686037; c=relaxed/relaxed;
	bh=JU5cz6xNV2lW9Lt2TNuR7gxKeqtaJMDvKgaq7CNRcOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iehXUIYs6KdHpmdIYT3IpLyu8/OSQ75Lbmnjmojm2MbFoEzSZWex9BmKbiDioWBANUK2npE00sImG/KwqoX45rGlvPO3tq1gi46tYVI76qluFymUGpmIR1q937G3qjA/LL6lmAPyDBzICtZ3fGihoRXJ2hXyPCSjijYyYqUC1OV6imtKEe+Y3jc2uTlk+LApZCoL0fLwHXbY1Mhm1+vuTF4kEJebrMgXlgzPV5fs5r5zjNGbAp05Z49GfGNYoNGepTv/6w5B3OakUUXZyDm0qtmrQ5tYIdI3Ndoq7CH7+HevERNO4+VM3NR8gHqXXoFbJwGJdNjxO1cMAnqThhmjUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f3A0UJtl; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f3A0UJtl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKwSz0zgBz2yfD
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 10:27:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742686035; x=1774222035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pc4EaFka8WBeGBfYm0TdQucMC1+YmV4+nK+iUH4S1XA=;
  b=f3A0UJtlbWev5vI/j3AjV68ZRlLMu8JAZJChN4diOabafuRdmbkGFnRk
   w0NVTwWEIV3kLzxdAt1F64gS5aP2Ly2GaMCck90UA1B/5AyS2Xlbl32nH
   Mu/hvx8D3Y8WOh5Gq6hmRy9Jni2Ng9fLT52/r11WSbWO/2XJPZH93dkUw
   /WpJE3x99iZZdaLo4W6cyClRo/WQxZ9gSXphBCPg5dMBit2wcIN+2/lRj
   mVxnMnM+lU07jFlzemKbSCoDQozgu6kBJZ55eoj6EZMPkCzmr7WxsVDBI
   5vjIowpvuKVVY7EYbf6ej16pUHt3HPYjFD09i8/rm2fI2UWEoFxyinMjW
   A==;
X-CSE-ConnectionGUID: wRc5R2WJRm+9CQ0j0/2yoQ==
X-CSE-MsgGUID: KLBK8z+GTBaDq/7hwXa6Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="47698299"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="47698299"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 16:27:09 -0700
X-CSE-ConnectionGUID: Y78lcGebR4G74DzfyKPtTA==
X-CSE-MsgGUID: OAAblMt3QSaG9/0EZzoMxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="128925105"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 22 Mar 2025 16:27:07 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw8F6-0002Rx-1t;
	Sat, 22 Mar 2025 23:27:04 +0000
Date: Sun, 23 Mar 2025 07:26:46 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Gao Xiang <xiang@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>
Subject: Re: [PATCH v2 4/9] fs: minix: register an initrd fs detector
Message-ID: <202503230754.YpVap9pi-lkp@intel.com>
References: <20250322-initrd-erofs-v2-4-d66ee4a2c756@cyberus-technology.de>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-initrd-erofs-v2-4-d66ee4a2c756@cyberus-technology.de>
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Stecklina-via-B4-Relay/initrd-remove-ASCII-spinner/20250323-043649
base:   88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
patch link:    https://lore.kernel.org/r/20250322-initrd-erofs-v2-4-d66ee4a2c756%40cyberus-technology.de
patch subject: [PATCH v2 4/9] fs: minix: register an initrd fs detector
config: um-randconfig-002-20250323 (https://download.01.org/0day-ci/archive/20250323/202503230754.YpVap9pi-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503230754.YpVap9pi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503230754.YpVap9pi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/minix/initrd.c:23:34: error: too many arguments provided to function-like macro invocation
      23 | initrd_fs_detect(detect_minixfs, BLOCK_SIZE);
         |                                  ^
   include/linux/initrd.h:63:9: note: macro 'initrd_fs_detect' defined here
      63 | #define initrd_fs_detect(detectfn)
         |         ^
>> fs/minix/initrd.c:23:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      23 | initrd_fs_detect(detect_minixfs, BLOCK_SIZE);
         | ^
         | int
   2 errors generated.


vim +23 fs/minix/initrd.c

    22	
  > 23	initrd_fs_detect(detect_minixfs, BLOCK_SIZE);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

