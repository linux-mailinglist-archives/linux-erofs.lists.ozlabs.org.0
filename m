Return-Path: <linux-erofs+bounces-115-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948A3A6CD38
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Mar 2025 00:27:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKwT14PRLz2ygn;
	Sun, 23 Mar 2025 10:27:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742686037;
	cv=none; b=P5mPFMBlDbY1dwVzORTDmUuudrHeLCMYPrgbU2C3QOrdfH+fEasmPS/OpKgoNI1cf6iT0+VZoWe7Pw6CZa3isCyDiaNENJkjqfCyu09D/hlmIMhp83Lx2dR3t0oM9i/0kp05bBDNmJr8XlqXPQ4OEewMfxqzqhw4zbjKFoIl+yoWnDjoyhy1m9ilnpAGmDlixJy36JXZ48C+PZDCaEQkutCfQYYaJWEkhlBKv5KJu07Ry9YFK6UaIVOhEMp8JZsOKu/u9LXSl/M9em2ztHiX8ZxQVOdEJ4aFgJApAcZslzGZq/nGelc6MuJ0UJFLzXIaOefRFfhi1qgvnfeLNUYC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742686037; c=relaxed/relaxed;
	bh=ALunj1wzCAeabKBmtHZF5jTJsQY2D9a+SSImSY1QJ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icd3gr246X3QepITnl9jWmqaKWQ75aW4wl4L0eZZ6r7QoEB8VpE4SW6X+8Ji/MNjeomY0w5ztSwXWLv4xVz6m6pKYOT/61nO0b9CgeNgVRTBDW6100kbgE8U+ZC/eXLz4xqkm4xP2fgkZLrMWIEplWPMKQ4JnNyR86l6aCF7DOXrShXYYHjZeXkgRJWJCFcfjnxRp/wOEQkgA/ZLBqoUhqNzhrZtLk79FXYQphGY8vSrEFO7AcMaE4dOwM9XxJP7yS7LVFejNCuNx0vO4ZnbXtfM6vdDxFwF62inqr9OyiIktIiFMgQDPtkWZx1nbBOxQu6XBiLyVZRzADdfjGIpDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GaMHlwrG; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GaMHlwrG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKwSz1pHdz2ygk
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 10:27:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742686035; x=1774222035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HtOa37cx/H9hJIAL1yKGAH93P+7CkYj34IpV2IECwOg=;
  b=GaMHlwrGFcm9qYPRSMo/hC/nhpHyCsQTOSkvDVe6qZFjzey/ZFdrQcZ3
   y6Wyv9WLRZVss7SehA7qONqXaD0l/QpTxygyL7eS3wjunNY6Z5s+6uKGR
   qsKdXiuJJJo821HKQ55sfEB2E6pCp88ZDyQnDr8YzLn3cg9gDUW5zbcSv
   15xlm9pZw9NnhWwEk/XhGBvcscgc2gEEVKfHkmsW+iGO5hUfOvBmQ+PVm
   vCR62tY5M/eFH3M6Vt9zI+FGjcCNIQetfT0kq31bqBCNzoOs45Rcj26N+
   5jDIhxU+wYm/JB/GC9um1jQvMsCpb3R+XBzUfGJ2BzLy4/hy7ssaxetmE
   A==;
X-CSE-ConnectionGUID: s+AAOk/7SDOt08z7JEPP0Q==
X-CSE-MsgGUID: NHouIPDWQUijGqltRI3MwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="66385235"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="66385235"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 16:27:10 -0700
X-CSE-ConnectionGUID: yJNrLWFySMWgkFMoXETkXQ==
X-CSE-MsgGUID: Q/4tgiyyTT2XVEND3y7xFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="127854080"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 Mar 2025 16:27:07 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw8F6-0002S0-1x;
	Sat, 22 Mar 2025 23:27:04 +0000
Date: Sun, 23 Mar 2025 07:26:45 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Gao Xiang <xiang@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>
Subject: Re: [PATCH v2 6/9] fs: romfs: register an initrd fs detector
Message-ID: <202503230701.JV9cV28A-lkp@intel.com>
References: <20250322-initrd-erofs-v2-6-d66ee4a2c756@cyberus-technology.de>
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
In-Reply-To: <20250322-initrd-erofs-v2-6-d66ee4a2c756@cyberus-technology.de>
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Stecklina-via-B4-Relay/initrd-remove-ASCII-spinner/20250323-043649
base:   88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
patch link:    https://lore.kernel.org/r/20250322-initrd-erofs-v2-6-d66ee4a2c756%40cyberus-technology.de
patch subject: [PATCH v2 6/9] fs: romfs: register an initrd fs detector
config: i386-buildonly-randconfig-002-20250323 (https://download.01.org/0day-ci/archive/20250323/202503230701.JV9cV28A-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503230701.JV9cV28A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503230701.JV9cV28A-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> fs/romfs/initrd.c:22:33: error: macro "initrd_fs_detect" passed 2 arguments, but takes just 1
      22 | initrd_fs_detect(detect_romfs, 0);
         |                                 ^
   In file included from fs/romfs/initrd.c:4:
   include/linux/initrd.h:63: note: macro "initrd_fs_detect" defined here
      63 | #define initrd_fs_detect(detectfn)
         | 
>> fs/romfs/initrd.c:22:1: warning: data definition has no type or storage class
      22 | initrd_fs_detect(detect_romfs, 0);
         | ^~~~~~~~~~~~~~~~
>> fs/romfs/initrd.c:22:1: error: type defaults to 'int' in declaration of 'initrd_fs_detect' [-Werror=implicit-int]
>> fs/romfs/initrd.c:8:22: warning: 'detect_romfs' defined but not used [-Wunused-function]
       8 | static size_t __init detect_romfs(void *block_data)
         |                      ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/initrd_fs_detect +22 fs/romfs/initrd.c

     2	
     3	#include <linux/fs.h>
   > 4	#include <linux/initrd.h>
     5	#include <linux/magic.h>
     6	#include <linux/romfs_fs.h>
     7	
   > 8	static size_t __init detect_romfs(void *block_data)
     9	{
    10		struct romfs_super_block *romfsb
    11			= (struct romfs_super_block *)block_data;
    12		BUILD_BUG_ON(sizeof(*romfsb) > BLOCK_SIZE);
    13	
    14		/* The definitions of ROMSB_WORD* already handle endianness. */
    15		if (romfsb->word0 != ROMSB_WORD0 ||
    16		    romfsb->word1 != ROMSB_WORD1)
    17			return 0;
    18	
    19		return be32_to_cpu(romfsb->size);
    20	}
    21	
  > 22	initrd_fs_detect(detect_romfs, 0);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

