Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E999E263
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 11:11:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSSy333jzz3bpn
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 20:11:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728983466;
	cv=none; b=U3V65oyFGaKAchYufPyUounREW0EIMkPG488Rg9aS6plb/IqxEDWmd89Cn1WJ0QxBCkHr9V8Kf5tgRNE8PWNDBpxA62NcnS8J2/FBEf4ApW/NoWdEX3dUytyN4Q0go6UMzEd6akvyFX8Vjo8gSVAJ7YAWtv0/7M7TlejU6uGquaeGcNvOvXfbAvHusIEwRcIXWTn9sCtIPVZ/B77bU4hfVchkqfkuT/ocdqTWdwAm/L1zf9lFJiwfatiQOyM/elT2R8xAaqxT114zTnNQdMYEiIwtPniQ1WzSLgLYzpja8MTQDKCAsvoRSUIBQ9slovbdOAT4svUzP7+HxAlYVB7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728983466; c=relaxed/relaxed;
	bh=h5D/bFMKCf9XcwyqPiJ32DXbOFzCGsMRYuzWv6PI5jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K7iaff2X9713Zy67oAiuk5h+rRNbLsOcfl6d/817Dtbg7eh5pOzz7UqZPNf/6wHOM3geXTnXi4emFLDF2XIv4ipeielrzZSQf2s+y8EbBbIRMIF+TtOmVr4FIEb69+DOUajvtXKRwEsIMJzIxnIjoO8o19BeGyPP7czc/o21PSWtdf4PDpf7xP9+pseqiwKQo52gxxmqspOCHSYBBQi6ioHntcFrWscVgmcPQWx+D5zZcB8r5K2/xclgEuxu7BxoJj3O+wGHn9XDad2bQmCaMfUbvM0i7xV3Tp+M1ETomPlC4le94CHfwpKhe/yy2MJ/j6W33YB3tUi8xQmXemaqfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rCl6tHSh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rCl6tHSh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSSxw0Nknz3bk0
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 20:10:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728983448; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h5D/bFMKCf9XcwyqPiJ32DXbOFzCGsMRYuzWv6PI5jA=;
	b=rCl6tHShAPVKzFXuNZ1rJehpV6vGG/CY05/eTDh58fYqriNbPTfEGzQhhpkAjeb34hVY8C1xI8VD4lUCLRWx8RlerXopTX9ohoEnjAsA3GIErw+408Y1sR3C2fWUavJTIPsOWePEwGbTJIonLl85ldRWz976LMj2Fl+8xd3AGlw=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHD3S.B_1728983446 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 17:10:47 +0800
Message-ID: <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
Date: Tue, 15 Oct 2024 17:10:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
To: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>,
 brauner@kernel.org, chao@kernel.org, dhavale@google.com, djwong@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/10/15 17:03, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d61a00525464 Add linux-next specific files for 20241011
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=175a3b27980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8554528c7f4bf3fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1513b840580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1313b840580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f615720e9964/disk-d61a0052.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c4a45c7583c6/vmlinux-d61a0052.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d767ab86d0d0/bzImage-d61a0052.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/fce276498eea/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 56bd565ea59192bbc7d5bbcea155e861a20393f4
> Author: Gao Xiang <hsiangkao@linux.alibaba.com>
> Date:   Thu Oct 10 09:04:20 2024 +0000
> 
>      erofs: get rid of kaddr in `struct z_erofs_maprecorder`

I will look into that, but it seems it's just a trivial cleanup,
not quite sure what happens here...

Thanks,
Gao Xiang

