Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6E57C1C4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jul 2022 02:58:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LpDhk0Fvxz3c2q
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jul 2022 10:58:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZrOE8fOC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZrOE8fOC;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LpDhZ6mtTz2ynx
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jul 2022 10:58:22 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 03243B82156;
	Thu, 21 Jul 2022 00:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A569DC3411E;
	Thu, 21 Jul 2022 00:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658365095;
	bh=4JdUnCsdBHN0EjyTXiz3Hpq6NmilTbZ1NX9AlgddAY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrOE8fOCEa33EOc+MrGdUHwW3fjksFG4cBop8yB7tFVDHo9BjzLias1jzWRyLH51v
	 fAGwV7BFYoPzMrUVIufvB1s6c0S5HsFxnX3Mg1TmRrmdgLgOkovrj1VqRm+7FzilPq
	 GPzGid3zbu8wzs3tWci8GhRx6trPw/+1VSqkNF7TUUIknp9qM/n03brI45qcwPJTph
	 Vs/KsQGVjhvnVEL8obeie1jkjUuFr3UntAk8ZVz5yYaLdTiHIVnqBvC/ggsPtF316R
	 1ndpxPRulgVDszyAPwGH7iqjvCAd2DVB74IoCvU5WhXAJo3xFz8BwSwK7WbQ77V/V9
	 +56BE0d1w6kjw==
Date: Thu, 21 Jul 2022 08:58:10 +0800
From: Gao Xiang <xiang@kernel.org>
To: Paul Spooren <mail@aparcar.org>
Subject: Re: Tail packing feature on 5.15 Kernel
Message-ID: <YtikopUfGNUsVfP+@debian>
Mail-Followup-To: Paul Spooren <mail@aparcar.org>,
	linux-erofs@lists.ozlabs.org
References: <DA1A8293-6DE7-49EA-B109-162B121C601A@aparcar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DA1A8293-6DE7-49EA-B109-162B121C601A@aparcar.org>
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

Hi Paul,

On Wed, Jul 20, 2022 at 10:38:15PM +0200, Paul Spooren wrote:
> Hi all,
> 
> I’m currently in the process[1] to evaluate erofs as a replacement of squashfs on OpenWrt.
> 
> Since 5.15 will be our next Kernel release but tail packing is only available starting from 5.17, did anyone already do the work of back porting the required patches? If not, could anyone please give me pointers which patches are required?
> 
> Thank you very much for all further advice!

Thanks for your interest.

EROFS is now actively developing so you could see new features
on each new Linux version (I believe many active in-kernel features
behave like this, for example iouring.)

The initial EROFS version was formed as an optimized solution to
compress in 4KiB pcluster so it has minimized memory footprints
and best random performance on Android smartphones, for now the
optimized and recommended configuration is still this one (4KiB,
lz4hc) even though things are quickly changing since recent features
add more possibility but most of these are still quite new and need
to go with the next LTS version (maybe 6.0?).

Also if you'd like to maximize the compression ratio you probably
need `fragments` features which is still under development by Yue
Hu [1].  As I said to you before [2], I still suggest that Openwrt
takes EROFS as an _alternative approach_ instead of a replacement
of Squashfs at least this year since we still need time to optimize
the maximum compression ratio scenarios in addition to 4KiB, lz4hc
(we also need to wait the next stable XZ-utils version first.)

[1] https://lore.kernel.org/r/YpXnhI8gBlSgHEBW@B-P7TQMD6M-0146.local
[2] https://lore.kernel.org/r/cover.1657528899.git.huyue2@coolpad.com

Thanks,
Gao Xiang

> 
> Best,
> Paul
> 
> [1]: https://github.com/openwrt/openwrt/pull/9968


