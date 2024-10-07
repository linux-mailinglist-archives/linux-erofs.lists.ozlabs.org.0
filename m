Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E7992A4A
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Oct 2024 13:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728300956;
	bh=BFgcGyzFhG5Zh5O9T+/jvQ6sBlhmkp1A05Mav6sNJ4A=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TJFYAicfi6OpbPY7l83lfletEPsu5Y6hZePflQw0A/OdwiH73fdzRKoxOZV0gzIhK
	 HwXXrJqDCCAroQ55lhA8xOnswcTu29qm5TF4h68MshQvnt1/XWaON9ei7GsUz02KQi
	 K9L1jqB40NoB9OXAs71np8K1MaiPMwbA/RocSBrQpSXQOMUCjONeMMZwE2FHDmKEQT
	 NEBUp88Vyynl369xZSnxoFZvErh3EMhundL9biV+ySyfExm2irqvdCGrX33NdQG8un
	 2rAZfi7qdI2GiMu7h3wfphFz/UCUaalCIgArjhMYwi6ACtjhMR0SMMCQeRD1JsR3RF
	 S2SAq0BUbtJqg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XMcXr1W8lz2yxN
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Oct 2024 22:35:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728300954;
	cv=none; b=cW2afw74gXWRGgxEYZSYKIPksr8prJAgHYpSbYbnRmAKU7RnqI1iDc738H8z/juJ24MIUfFWWMiwiFbaUpeywdoYm16rTVwD0xuYMnzOh7V8FDLGjo4OtTcJI/qCtvQNHgAFHo7a6ob3CA+rN0breD3lvMj3uGn0VqDTZ+wzToO3qyDleqPpZgM3uw8Xmlu8ILUi4lBJAqLCQA3t9xM+XjnhuRwB1UqZS/TcxEmvrThcY+GqD75NApj/tcco+CzdGXZyA9NtJFQDRy0NgwUc++3EjU5+pIrPWF9oIhMrgRF23FbJ7RDGMUrF8YfDvx9xdwwBz9jtrhswbEBS4JUYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728300954; c=relaxed/relaxed;
	bh=BFgcGyzFhG5Zh5O9T+/jvQ6sBlhmkp1A05Mav6sNJ4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLasfROQc78W6vSmThC+DZmyuqNGmGdPFtTypuCko3GRz4Z3aDrPIOGpSvSJxZeIwQjosrW+yRn7RNEHjANh20hv+RwvfFNKKvPXKiYC1Ny/Ss9DrnLOzUYMUnp/X9lT0vh1+QHWEY9TlrxLfOnZ0RDg8bdjQFllZNo2ld6LPtEARKdXPYCr2cZRegBXG4APOEqdkNYcKdsxQW05mjDYO3nD0Yf53fZvHkrF5v71yKa8quHnXA3Uy3xPIiYAULUp5SM14HY4JvnPqHuvFghdDfQ+AWEJ1hX7hfBRDcp2znGIH1WxpYeLnIkqixt+qKiqWPgCbIOlb5/VieTja4Hqug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h9uZIOmH; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h9uZIOmH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XMcXn1zK6z2xnc
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Oct 2024 22:35:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 512C7A41B18;
	Mon,  7 Oct 2024 11:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D63C4CEC6;
	Mon,  7 Oct 2024 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728300950;
	bh=ExKbvQRI59nD5ZMwmjywvVJv7FMUpq4qs89AG+vLOVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9uZIOmHqzcJgOt4HVOEph+iRZunjAuniSYZE9C65r/KP5PMRM6X0GzmRxWBYMXib
	 p/Eg4DiKZC+cO8RPUdVlCfweFjUSOfzk3W8gWbGocH6IPJ9IQ8sJbhqh79ekmfakiM
	 Xvpa5FrbWzK+ftuKDBTBmLBYe6pPaaiNAOWRYmSMs+veyCaQ1CCyS+S9JOpR7NzAoW
	 4LuHxDi6MIlQDBPe2ujHhNxtOq0augGFUJydCaa/MUMv9x3rU7IIAT2y7R9gtq9C9H
	 NCe3ztXdyQLQ2Isy2T7TJiVyPPalm/PWVqiwbv11zXbBGCmiIFcY55lE7G8cx/aBpg
	 PA0RbpmD+3ScA==
Date: Mon, 7 Oct 2024 13:35:46 +0200
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
Message-ID: <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
 <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Oct 05, 2024 at 10:41:10PM GMT, Gao Xiang wrote:
> Hi Allison,
> 
> (try to +Cc Christian)
> 
> On 2024/10/2 20:58, Allison Karlitskaya wrote:
> > hi,
> > 
> > In context of my work on composefs/bootc I've been testing the new support for directly mounting files with erofs (ie: without a loopback device) and it's working well.  Thanks for adding this feature --- it's a huge quality of life improvement for us.
> > 
> > I've observed a strange behaviour, though: when mounting a file as an erofs, if you read() the filesystem context fd, you always get the following error message reported: Can't lookup blockdev.
> > 
> > That's caused by the code in erofs_fc_get_tree() trying to call get_tree_bdev() and recovering from the error in case it was ENOTBLK and CONFIG_EROFS_FS_BACKED_BY_FILE.  Unfortunately, get_tree_bdev() logs the error directly on the fs_context, so you get the error message even on successful mounts.
> > > It looks something like this at the syscall level:
> > 
> > fsopen("erofs", FSOPEN_CLOEXEC)         = 3
> > fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
> > fsconfig(3, FSCONFIG_SET_STRING, "source", "/home/lis/src/mountcfs/cfs", 0) = 0
> > fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
> > fsmount(3, FSMOUNT_CLOEXEC, 0)          = 5
> > move_mount(5, "", AT_FDCWD, "/tmp/composefs.upper.KuT5aV", MOVE_MOUNT_F_EMPTY_PATH) = 0
> > read(3, "e /home/lis/src/mountcfs/cfs: Can't lookup blockdev\n", 1024) = 52
> > 
> > This is kernel 6.12.0-0.rc0.20240926git11a299a7933e.13.fc42.x86_64 from Fedora Rawhide.
> > 
> > It's a pretty minor issue, but it sent me on a wild goose chase for an hour or two, so probably it should get fixed before the final release.
> > 
> 
> Sorry for late response. I'm on vacation recently.
> 
> Yes, I also observed this message, but I'm not sure
> how to handle it better.  Indeed, the message itself
> is out of get_tree_bdev() as you said.
> 
> Yet I tend to avoid unnecessary extra lookup_bdev()
> likewise to confirm the type of the source in advance,
> since the majority mount type of EROFS is still
> bdev-based instead file-based so I tend to make
> file-based mount as a fallback...
> 
> Hi Christian, if possible, could you give some other
> idea to handle this case better? Many thanks!

(1) Require that the path be qualified like:

    fsconfig(<fd>, FSCONFIG_SET_STRING, "source", "file:/home/lis/src/mountcfs/cfs", 0)

    and match on it in either erofs_*_get_tree() or by adding a custom
    function for the Opt_source/"source" parameter.

(2) Add a erofs specific "source-file" mount option. IOW, check that
    either "source-file" or "source" was specified but not both. You
    could even set fc->source to "source-file" value and fail if
    fc->source is already set. You get the idea.

?
