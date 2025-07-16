Return-Path: <linux-erofs+bounces-644-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0947BB07FCA
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 23:41:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bj8df74R4z3bby;
	Thu, 17 Jul 2025 07:41:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752702102;
	cv=none; b=dDp34q467n/eIcWWLXIA9fXhwqDy5VEWttsqZDiJD7uLnvUejy0nSRtS3z2pZlXxn+FNQksUaMqd2sovpWiVUujzkOkdvEkuAWSAfVPOVcA8tv0wBnVulyPI4HjzEDK0nQFZXwy13hgPOMWHfBo+FC2RBZWQYn+8yg7ybUR/T5TYLtVuLJSjzu2/SVY/509m/VJPNnLQTnDNlS84p3rtzf1DFfZBnPXDlZ9ZGWsztSnLw4Ad7ebkRJTObT1qktiA+Rc08ExCOJaDpyqnluH8UxZ0PQ50L8pydXgdvYjuA8LZEfySKZj6dATB1kZ1KRmP2omiK0fzNHR3oSP1qsJ8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752702102; c=relaxed/relaxed;
	bh=LapNa/l4khs4D9QAnepv8/Zpkwj2fZdqLX3POoTk4Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XckstxZC2CnnScyxrjYB93eNrs4uOU0VwpLCmQtcvJNVyGh7ir7c6U0KtxxkoiYgkAK4skP4hQy0/yPZsns04gh/2rZjUkGUjTQ74ba07RBZ5nI5MSpoB30FJLNm10JYognrVuiI26lZIGQxxnzFWLXu+1WahKro5Vw5hLChaSsmliY+xzV7lKoQcs31NLap0dr77gdt6WVv+hza3AAIX9tGco0dyqo3RLqjwwP/fGFR5FtWEw5WFfZkLB1+/OsYwIFvy3YPwzNssNBfWpJ3xrk/9KlJ6XBxK1u2mqQnZW41ua6/nNho4tIdmwJ8Zdq4oUzSXRoPO9I2swjPwXuNag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fiRN5uCS; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fiRN5uCS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bj8df1gvCz30Vn
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 07:41:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752702102; x=1784238102;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ejg2NgilfZsuVgEFKYoLPFPHlHYZj5/iFnKoONmMhKg=;
  b=fiRN5uCSnqFHmxi8XpKtbRPDU82Je7TmX4PsXQaZUtistZuulDP855+V
   qecWPqs69iIk36YpTxqVoQH3okqOT+6XoyCaHXmnt9toAg21+tqP+wRyP
   JSmBLeoTGHSCLabwZuNJsmW4QgoBP90PqhMTIkLqV0HZzKTnlOZchNr8K
   /MJbN371af0wTECEw0DsMre0f3jXm1eUoHmqLCmA0zwDqcs+LLmDInxuD
   cNqbA6HBMXBZGLzJKrcQsFqFm4YlOrlZT6hb9agp2/32Euv7h2F3mz1Ss
   PVnfSaywE4a6TfMskT5iS8s67d3jd1RSeFHRNgrvnQT3bjaeqFQb/1K7H
   w==;
X-CSE-ConnectionGUID: q+PzUiZmQNKwV7TiNC4y7A==
X-CSE-MsgGUID: 3avBduc3TxmdQ2OCND7sjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58734945"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="58734945"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:41:34 -0700
X-CSE-ConnectionGUID: 82IF38aYQYCyYIQnQH3sJQ==
X-CSE-MsgGUID: McomF0g2SXOr2Hp0Kq6nvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157285490"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2025 14:41:32 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc9sY-000CsC-2C;
	Wed, 16 Jul 2025 21:41:30 +0000
Date: Thu, 17 Jul 2025 05:40:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test 7/7] fs/erofs/internal.h:288:31: warning:
 shift count >= width of type
Message-ID: <202507170506.Wzz1lR5I-lkp@intel.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   33656c801bc94615e8b02f01f36eff752dc5086b
commit: 33656c801bc94615e8b02f01f36eff752dc5086b [7/7] erofs: implement metadata compression
config: hexagon-randconfig-001-20250717 (https://download.01.org/0day-ci/archive/20250717/202507170506.Wzz1lR5I-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507170506.Wzz1lR5I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507170506.Wzz1lR5I-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from fs/erofs/data.c:7:
>> fs/erofs/internal.h:288:31: warning: shift count >= width of type [-Wshift-count-overflow]
     288 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   In file included from fs/erofs/data.c:7:
   fs/erofs/internal.h:294:45: warning: shift count >= width of type [-Wshift-count-overflow]
     294 |         erofs_nid_t nid_lo = EROFS_I(inode)->nid & EROFS_DIRENT_NID_MASK;
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
   fs/erofs/erofs_fs.h:275:33: note: expanded from macro 'EROFS_DIRENT_NID_MASK'
     275 | #define EROFS_DIRENT_NID_MASK           (BIT(EROFS_DIRENT_NID_METABOX_BIT) - 1)
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   2 warnings generated.
--
   In file included from fs/erofs/super.c:14:
   In file included from fs/erofs/xattr.h:9:
>> fs/erofs/internal.h:288:31: warning: shift count >= width of type [-Wshift-count-overflow]
     288 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   In file included from fs/erofs/super.c:14:
   In file included from fs/erofs/xattr.h:9:
   fs/erofs/internal.h:294:45: warning: shift count >= width of type [-Wshift-count-overflow]
     294 |         erofs_nid_t nid_lo = EROFS_I(inode)->nid & EROFS_DIRENT_NID_MASK;
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
   fs/erofs/erofs_fs.h:275:33: note: expanded from macro 'EROFS_DIRENT_NID_MASK'
     275 | #define EROFS_DIRENT_NID_MASK           (BIT(EROFS_DIRENT_NID_METABOX_BIT) - 1)
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
>> fs/erofs/super.c:327:26: warning: shift count >= width of type [-Wshift-count-overflow]
     327 |                 if (sbi->metabox_nid & BIT(EROFS_DIRENT_NID_METABOX_BIT))
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   3 warnings generated.
--
   In file included from fs/erofs/fscache.c:8:
>> fs/erofs/internal.h:288:31: warning: shift count >= width of type [-Wshift-count-overflow]
     288 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   In file included from fs/erofs/fscache.c:8:
   fs/erofs/internal.h:294:45: warning: shift count >= width of type [-Wshift-count-overflow]
     294 |         erofs_nid_t nid_lo = EROFS_I(inode)->nid & EROFS_DIRENT_NID_MASK;
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
   fs/erofs/erofs_fs.h:275:33: note: expanded from macro 'EROFS_DIRENT_NID_MASK'
     275 | #define EROFS_DIRENT_NID_MASK           (BIT(EROFS_DIRENT_NID_METABOX_BIT) - 1)
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
>> fs/erofs/fscache.c:277:46: error: too few arguments to function call, expected 4, have 3
     277 |                 src = erofs_read_metabuf(&buf, sb, map.m_pa);
         |                       ~~~~~~~~~~~~~~~~~~                   ^
   fs/erofs/internal.h:400:7: note: 'erofs_read_metabuf' declared here
     400 | void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
         |       ^                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     401 |                          erofs_off_t offset, bool in_metabox);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.


vim +288 fs/erofs/internal.h

   285	
   286	static inline bool erofs_inode_in_metabox(struct inode *inode)
   287	{
 > 288		return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
   289	}
   290	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

