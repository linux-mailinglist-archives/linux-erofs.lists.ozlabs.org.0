Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF88402199
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 02:13:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3Qhx0whLz2yHD
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 10:13:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mWK/O0Je;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mWK/O0Je; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3Qht0cRPz2xtV
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Sep 2021 10:13:17 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 331C26109D;
 Tue,  7 Sep 2021 00:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630973595;
 bh=h8sS6fhCsLaxVgbfHdeJG93QNaiq4Fo+C+TufZx+Upk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mWK/O0JeBPFYIOL9+PBq+G33vwMnu6LK6ZUeXZGAcp7q1bOuaZ1gHR9o0KAyhs6Jn
 vcPgWGf0gDAM701i5Zc056BzjzFLThc6kBAT6vQrpRbe9jOvisux+pyWxDhJdttbl7
 Q4bLe4aeViqPtv/b0cgetcwc5Hdrj4GfaPqvKCCshK0WDDgRHuaM37w0DJ4ItKo2tZ
 D5mJKNOe9aUTu3xXYsYNh7Cz/1VpwCuIW7Zgt3rQ1aHOpG4PRiXm5+znMn19EnFqeG
 SI699l+hZ4ET5mTTWR+VVUYOHeBixZ96xf1dvdr5wtKQJ9yLcp17L+Xk1zs5vPy0yr
 vEtqwHmI47CRA==
Date: Tue, 7 Sep 2021 08:12:55 +0800
From: Gao Xiang <xiang@kernel.org>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v3] erofs-utils: support per-inode compress pcluster
Message-ID: <20210907001250.GD23541@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <huangjianan@oppo.com>,
 linux-erofs@lists.ozlabs.org, yh@oppo.com, kevin.liw@oppo.com,
 guoweichao@oppo.com, guanyuwei@oppo.com
References: <20210818042715.24416-1-huangjianan@oppo.com>
 <20210825033523.20058-1-huangjianan@oppo.com>
 <20210905175919.GA24755@hsiangkao-HP-ZHAN-66-Pro-G1>
 <c234da57-dc77-e1c9-d17e-41e4e873834e@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c234da57-dc77-e1c9-d17e-41e4e873834e@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 06, 2021 at 05:38:43PM +0800, Huang Jianan via Linux-erofs wrote:
> 在 2021/9/6 1:59, Gao Xiang 写道:
> > On Wed, Aug 25, 2021 at 11:35:23AM +0800, Huang Jianan via Linux-erofs wrote:
> > > Add an option to configure per-inode compression strategy. Each line
> > > of the file should be in the following form:
> > > 
> > > <Regular-expression> <pcluster-in-bytes>
> > > 
> > > When pcluster is 0, it means that the file shouldn't be compressed.
> > > 
> > > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > > ---
> > > changes since v2:
> > >   - change compress_rule to compress_hints for better understanding. (Gao Xiang)
> > >   - use default "-C" value when input physical clustersize is invalid. (Gao Xiang)
> > >   - change the val of WITH_ANDROID option to a separated patch. (Gao Xiang)
> > > 
> > > changes since v1:
> > >   - rename c_pclusterblks to c_physical_clusterblks and place it in union.
> > >   - change cfg.c_physical_clusterblks > 1 to erofs_sb_has_big_pcluster() since
> > >     it's per-inode compression strategy.
> > > 
> > Hi Jianan,
> > 
> > I sorted out a version this weekend (e.g. bump up max pclustersize if
> > needed and update the man page), would you mind confirm on your side
> > as well?
> Hi Xiang,
> 
> Thanks for your modification, looks good to me.
> > Also, it'd be better to add some functionality testcases to cover this
> > if you have extra time:
> Ok, should I use the experimental-tests branch now?

Yeah, please check out this if you have extra time.

Thanks,
Gao Xiang
 
> 
> Thanks,
> Jianan
> > Thanks,
> > Gao Xiang
