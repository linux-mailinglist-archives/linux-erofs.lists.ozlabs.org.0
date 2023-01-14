Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8CD66A926
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 05:13:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nv4fS6rkFz3fBy
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 15:13:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ViHxZIuH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ViHxZIuH;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nv4fK0xVvz3c7Q
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jan 2023 15:13:45 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 979B6B822BF;
	Sat, 14 Jan 2023 04:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F40EC433EF;
	Sat, 14 Jan 2023 04:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673669619;
	bh=rDUUQRNZS3av5hs/mcvGAWdmXs7ftndncmP3Hclnl2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViHxZIuHwugxSwoXZ+MpoOLvlz1n9U1vCYlVZQRDMXcMlUj2MskgeGNLyqBD4BpQT
	 l9yBHLG9Q+M9V+DVQTgns+tcKybQGtdOrZqEDwvhcCa6yl2TTKhrMWBc+rfBxReoyr
	 5LqKzEz5uO4v6jq0I3FrLJlRQPfjoHOK3lj6+Q3LOOI6+iopOcBBm7V+Nd7wGZrVa1
	 85XpqrWKc76QX98pKK5u680vaLZQyVvDg+Du5qQcSsLPmqSkwQXa8+3+eo9moE61DY
	 nUJxNPoggdGqLp+Vl/GyOSTF2apP1mi9hIYdtQnpv3cSvbRnOm0zm2LfQp9ElUVKZv
	 juYF2YyX7d0Pw==
Date: Sat, 14 Jan 2023 12:13:33 +0800
From: Gao Xiang <xiang@kernel.org>
To: kernel test robot <lkp@intel.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] erofs: cleanup erofs_iget()
Message-ID: <Y8Ir7ditI6TPcuwI@debian>
Mail-Followup-To: kernel test robot <lkp@intel.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, LKML <linux-kernel@vger.kernel.org>,
	oe-kbuild-all@lists.linux.dev
References: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
 <202301141147.AYezdBCD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202301141147.AYezdBCD-lkp@intel.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, oe-kbuild-all@lists.linux.dev, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jan 14, 2023 at 11:59:41AM +0800, kernel test robot wrote:
> Hi Gao,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on xiang-erofs/dev-test]
> [also build test WARNING on xiang-erofs/dev xiang-erofs/fixes linus/master v6.2-rc3 next-20230113]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Gao-Xiang/erofs-remove-linux-buffer_head-h-dependency/20230114-100018
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
> patch link:    https://lore.kernel.org/r/20230114015812.96836-1-hsiangkao%40linux.alibaba.com
> patch subject: [PATCH v2 1/2] erofs: cleanup erofs_iget()
> config: ia64-allyesconfig
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/ede350f68141cc6bdc88c627e0f8f992f1b26307
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Gao-Xiang/erofs-remove-linux-buffer_head-h-dependency/20230114-100018
>         git checkout ede350f68141cc6bdc88c627e0f8f992f1b26307
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash fs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    fs/erofs/inode.c: In function 'erofs_squash_ino':
> >> fs/erofs/inode.c:319:28: warning: right shift count >= width of type [-Wshift-count-overflow]
>      319 |                 ino ^= nid >> sizeof(ino_t) * 8;
>          |                            ^~

Okay, I think I have to stick to v1 since v2 causes a
compile warning.

Thanks,
Gao Xiang
