Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5C62E08AD
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 11:18:27 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0XNc5f4LzDqQS
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 21:18:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b;
 helo=mail-pf1-x42b.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eLcF3s9v; dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0XNP74BszDqGM
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 21:18:10 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id t22so8218275pfl.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y+ZohZ/UIwJ3EY6y5HTSTvmVNdi2EWoqlONTDYqQrBk=;
 b=eLcF3s9v/7dKKNi6oye6ltlhJSgfEU6hd6209p1BetHpNhCiSNajUZGR8GL1VxdHZq
 Dc9fIEqBKxb7+pexEgo4hVVUrQ2e1VG0e54qy5ZtfEUgCoURPmGXmGyy300Rt4kCBx0q
 vwmKQZmqt+gWdbidkFijoGGp4+GlsdBIdBfXHizk668vMP1CXlalTi5IL7KY/g5YiDMi
 IlGk6B3Kug2Q4k1rA7SIsUEiUiNu5AKkWTgaVm1C+EtYfpOalmo3fOZozu28+xOtzn5f
 SD9RKtAuHpYx6YjKA2LINrNVs3sxAnDF/aO/JxfaY6asg+3yogpjzg7p/DR9V6JcOyQY
 Yr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y+ZohZ/UIwJ3EY6y5HTSTvmVNdi2EWoqlONTDYqQrBk=;
 b=HFURXfVKOWK0Gl+DgM66ZcJk4XAJWXWK8AcQKASlzWWWosx/Tpr2ZcylhxoQMyFX3W
 drCWz6EgdV4Cp/MqbyUvmHRdJcQNezgCgfgoFchy37jVHc6UsGSDRAaOVOFH6CjLJhDA
 cUzkkDDLVpMdTslzcc6xAoKEsxUBG23TTmQfkxyrmIwXjfymF/TJZUqyeXCSw0ZYmNhJ
 4nsx5WKSPS8vxuqQCecnuo7B/FkeEEt6O8xHfL9Xxfi+cElEstYUP4hdy0Myp2E8zu+m
 y7HC9Uh0c/+RFVWZic0LEPC2ZxD4C8hWUdJC8X0+Hr1oUB0YvFifclq7q7YE4kj/SoZ3
 rk5Q==
X-Gm-Message-State: AOAM531X5w5FTX+T3UiWzfrio8u/hMnT21m/7yQ6IULvfRzKgKont6zk
 OAZzIRpBkMO6IWb4OJYPLiw=
X-Google-Smtp-Source: ABdhPJzcfk9rerbFJqOHAm6PhDzZrLfzisVJqCZct0oPT7jhfdiA/Nw9pmaWQHLgLE/3gwCZAgMhGA==
X-Received: by 2002:a62:38cf:0:b029:19e:41ac:526b with SMTP id
 f198-20020a6238cf0000b029019e41ac526bmr19302425pfa.0.1608632286893; 
 Tue, 22 Dec 2020 02:18:06 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id c5sm12291443pgt.73.2020.12.22.02.18.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Dec 2020 02:18:06 -0800 (PST)
Date: Tue, 22 Dec 2020 18:17:51 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222181751.00004a42.zbestahu@gmail.com>
In-Reply-To: <20201222095906.GA1826582@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
 <20201222093952.GC1819755@xiangao.remote.csb>
 <20201222174623.00005f9b.zbestahu@gmail.com>
 <20201222095906.GA1826582@xiangao.remote.csb>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 22 Dec 2020 17:59:06 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> On Tue, Dec 22, 2020 at 05:46:23PM +0800, Yue Hu wrote:
> > On Tue, 22 Dec 2020 17:39:52 +0800
> > Gao Xiang <hsiangkao@redhat.com> wrote:
> >   
> > > On Tue, Dec 22, 2020 at 05:30:14PM +0800, Yue Hu wrote:
> > > 
> > > ...
> > >   
> > > > > > 
> > > > > >       
> > > > > > > +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > > > > > +			  erofs_fspath(path)) <= 0)      
> > > > > > 
> > > > > > The argument of path will be root directory. And canned fs_config for root directory as
> > > > > > below:
> > > > > > 
> > > > > > 0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> > > > > > 
> > > > > > So, cannot add mount point to root directory for canned fs_config. And what about non-canned
> > > > > > fs_config?      
> > > > > 
> > > > > Not quite sure what you mean. For non-canned fs_config, we didn't observed any strange
> > > > > before (I ported to cuttlefish and hikey960 with boot success, also as I mentioned before
> > > > > some other vendors already use it.)
> > > > > 
> > > > > I think the following commit is only useful for squashfs since its (non)root inode
> > > > > workflows are different, so need to add in two difference place. But mkfs.erofs is not.
> > > > > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > > > > 
> > > > > For root inode is erofs, I think erofs_fspath(path) would return "", so that case
> > > > > is included as well.... Am I missing something?    
> > > > 
> > > > Yes, erofs_fspath(path) returns "" for root inode. However, the above patch add the mount
> > > > point to fspath when specify it, so the real path is "vendor/" which does not exist in canned
> > > > fs_config file. build will report below error:
> > > > 
> > > > failed to find [/vendor/] in canned fs_config    
> > > 
> > > Hmmm... such design is quite strange for me....  
> > 
> > :) i checked the squashfs before, seems root directory is handled in some position. Separated
> > with sub directory fs_config. so i add the goto code in the 1st patch.  
> 
> What confuses me a lot is that we didn't get any strange without canned fs_config
> if mount point prefix is added. I will look into other implementation about this
> later (Another guess is that relates to Android 10 only?).

maybe relates to dynamic partition(intro from Android 10) which not be enabled by some vendors.

> 
> Yeah, the opensource fs_config implementation might be different from HUAWEI
> internal fs_config version since such part was not originally written by me and
> I didn't pay more attention about this part when I was in my previous company.
> But anyway, this cleanup opensource version is already used for some vendors
> as well and I don't get such report... And any formal description about this
> would be helpful for me to understand how fs_config really works..

Now i'm not familar with fs_config also :) I will continue to check when i have
enough time.

Anyway, i observed the issue in canned fs_config since i'm using it. so i decide
to report it and patch it to upstream to verify if it's a real one.

Thx.

> 
> Thanks,
> Gao Xiang
> 
> >   
> > > Could you try the following diff?  
> > 
> > Let's me verify.
> >   
> 

