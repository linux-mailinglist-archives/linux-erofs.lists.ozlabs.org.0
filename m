Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D906541FFCD
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 06:38:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HMWMH4HJzz2yQB
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 15:38:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EJ35l4R/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EJ35l4R/; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HMWMD5hqXz2yNC
 for <linux-erofs@lists.ozlabs.org>; Sun,  3 Oct 2021 15:38:48 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCC7061352;
 Sun,  3 Oct 2021 04:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633235925;
 bh=qFhFo7KC4tYaVrTYl42Tz0qJXNIpzZ7CyqEz2s1gUUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EJ35l4R/J6fvgdXFrLD/U/JAf5Zhd8fwPC1ErHcVEi89iHvC4gWs6FsRog3C9JcGF
 EHFUyqbTv+ekLrYN9FB0ZsfyJtfG7iN1/Ls4BWufLXjvvIYZLuYBBGfWKVOEo5Flx7
 IQLkLyHNxOTv8TwgVB2BiVUjJLfzlG2hqLrmT4gGXUGNwyuazcZ4NyV0i2ciFbHkV9
 AWn8Mj+0PtZIOLqcirMN07/qEGv2wdvX85Jl+Y6+EIjAxmsFmsI9j2xJ8WKByM8kUc
 jxolkOL5r9leEJ0lngrqqDjdOQTdytKpBHpOYguSSS/8ZuoA98kCtIY7NN8l2iA+kI
 ZOcYSQ4LlVtUw==
Date: Sun, 3 Oct 2021 12:38:41 +0800
From: Gao Xiang <xiang@kernel.org>
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: SELinux labels not defined
Message-ID: <20211003043840.GA9546@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: David Michael <fedora.dm0@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <8735pjoxbk.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735pjoxbk.fsf@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Sat, Oct 02, 2021 at 06:50:55PM -0400, David Michael wrote:
> Hi,
> 
> I tried to make an SELinux-labeled EROFS image, and the image itself
> seems to contain the labels from a hex dump, but the mounted files are
> all unlabeled:
> 
> # ls -lZ xml
> total 8
> drwxr-xr-x. 2 root root unconfined_u:object_r:var_t:s0         4096 Sep 29 21:43 dbus-1
> drwxr-xr-x. 2 root root unconfined_u:object_r:fonts_cache_t:s0 4096 Sep 29 22:19 fontconfig
> # mkfs.erofs test.img xml
> mkfs.erofs 1.3-g4e183568-dirty
> 	c_version:           [1.3-g4e183568-dirty]
> 	c_dbg_lvl:           [       2]
> 	c_dry_run:           [       0]
> # mount -o X-mount.mkdir test.img test
> # ls -lZ test
> total 8
> drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 78 Oct  2 18:37 dbus-1
> drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 48 Oct  2 18:37 fontconfig
> 
> This is running on the current Fedora kernel 5.14.9-200.fc34.x86_64 with
> the relevant config options:
> 
> CONFIG_EROFS_FS=m
> # CONFIG_EROFS_FS_DEBUG is not set
> CONFIG_EROFS_FS_XATTR=y
> CONFIG_EROFS_FS_POSIX_ACL=y
> CONFIG_EROFS_FS_SECURITY=y
> CONFIG_EROFS_FS_ZIP=y
> 
> I tried the earliest kernel in Fedora 34 (5.11.12-300.fc34.x86_64), and
> it also has the same issue.  However, the earliest kernel in Fedora 33
> (5.8.15-301.fc33.x86_64) has the correct labels when the image is
> mounted.  Is there a problem in the file system driver, or do I need to
> do something different for newer kernels?

Thanks for your report!

I don't think there is any difference between 5.8 - 5.14 on EROFS selinux
xattrs. And AFAIK some users already use EROFS selinux on Linux 5.10.

Would you mind checking if Fedora kernels did something new for EROFS or
something else on fc34? Can you check if the images work on upstream
kernels?

For example, in my own testing environment (upstream kernel + buildroot):

# file: verity_key
security.selinux="u:object_r:rootfs:s0"

# uname -a
Linux buildroot 5.15.0-rc3+ #14 SMP Wed Sep 29 09:57:09 CST 2021 x86_64 GNU/Linux

Thanks,
Gao Xiang

> 
> Thanks.
> 
> David
