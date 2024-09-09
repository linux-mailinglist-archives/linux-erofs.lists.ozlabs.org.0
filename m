Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B1971147
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 10:11:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2KKV67qvz2yQl
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 18:11:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725869468;
	cv=none; b=oUrETn5KvR4pRN37Nvbb8jDYs1Rk8nYhdpbn9AyqHCPtla9nbqmnSk6wrdcPgKSM+NSgCVYRo6kbKRvUzWJPGBzfoH+lFNZlL3eMvAZxM0wIw50fy+/M4d6/ag7aVOFjbtfmIC/bteM7zso5I+Rrwnli9uuG39Ws1BGt1ROTnkAnIJrq9h8f/GwTqKm3s4Av6Yjs9c+6thVoD1os6aMd8C0wtgk7icmyAeGpK4W5W8wp8+LG2y0zQp0J9CP/WN+KjQsYc0tEhoQEN50EehEGM97PFmvkhuXCQU5ArIBPpHrEQiPQ7rjik8lMsQxXfpLuHBng8zhImsIBHkWmCCvo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725869468; c=relaxed/relaxed;
	bh=bg+dw748Ekv41AIrUpXBncf6hBGJfcOCAV3mjvwBexk=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=gLCVwTOXxCTAD/oKXCj8ploog28q8FJkYVYoiaM9z3HDugXWM9V8CApLZDT1isF0HfHGlDmyyGME4rgIajFL0K/f0v8KDeRDQ8OnDHNXHcMreVftjm9q962WKW9GIST4XU7TJwlvHe3kDhNYerxbRsJ3G1xiQLaOiaVQADQYwjvYHBKjL+gzwtCQAbHE4N5gmf+0xeDcjm3hM1Yg6Yp08mY1LsO01NSdjnR/qodB2F3wvG44veXWEgCA8beYkKImC0I90i3C9iaLYPYo9aPunbLLzFSuVIkDqjYbB0tpIq8VFOcpUnD4dNEr3iBVnlSCT5dGycPkvJ+b7hwdZaNoww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rYpYrVQs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rYpYrVQs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2KKQ4lZMz2yLJ
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 18:11:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725869460; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bg+dw748Ekv41AIrUpXBncf6hBGJfcOCAV3mjvwBexk=;
	b=rYpYrVQsyTj7LDIdOgvhoDeHkyxgTmk/8DO5HSh3pkJI21/bHdUpucb4fCra67kIF581rSipWGsS8Xy6Sda1o6pI6IsL3hm3p9QeSZMeYRrUGTTKMaU7h+iafuqWlEMIhRw1YiNzYC/zrq0ozxSG7WR426ZbXC7Nd+iPkQhWgug=
Received: from 30.221.130.133(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEZ5qAz_1725869458)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 16:10:59 +0800
Message-ID: <7c5c3524-8559-4112-904b-d9308b8633f3@linux.alibaba.com>
Date: Mon, 9 Sep 2024 16:10:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xiang-erofs:dev-test 9/12] fs/erofs/inode.c:19:56: error: 'off'
 undeclared
To: kernel test robot <lkp@intel.com>, Yiyang Wu <toolmanp@tlmp.cc>
References: <202409091602.2XlSy6FO-lkp@intel.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <202409091602.2XlSy6FO-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/9 16:07, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
> head:   c45b42bcbc9c3fb421b8a4f7b3112b401971530b
> commit: afcb9dd4a55ab82970251b75c2a5461025ed4d8a [9/12] erofs: refactor read_inode calling convention
> config: i386-buildonly-randconfig-003-20240909 (https://download.01.org/0day-ci/archive/20240909/202409091602.2XlSy6FO-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240909/202409091602.2XlSy6FO-lkp@intel.com/reproduce)
> 

It's a stale tree and already fixed.
