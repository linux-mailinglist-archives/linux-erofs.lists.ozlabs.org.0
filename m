Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDCC2E08DC
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 11:33:47 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0XkH6PD0zDqQW
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 21:33:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=b00coHTG; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JAMmPCKT; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0XkF0rm9zDqQ1
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 21:33:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608633215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wB8MRQUpweKwq9jSQ8KUju/K937jhxEhC3XXMpTCHUk=;
 b=b00coHTGOYNj5x6Ve2nSpRhMNKqvdmpo1v6l/4lB0Z9D1QquaFeQMKcWiRs+9cNBYKgkGp
 2Y9w3QUpJniJWAtcckIIYXHUAzT84K/yNZ1jG+xxW6zSxJpW8R0hNh3U9/q2HlOVimEVk2
 bwApkLxLNQLRNwpAm7lUr9CDqmN7clQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608633216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wB8MRQUpweKwq9jSQ8KUju/K937jhxEhC3XXMpTCHUk=;
 b=JAMmPCKTZzXWeq05yJLcT8zNbsh6GDWtVQTthODKdFdMbIk6a1GXXtv16xMLohUx1Pqzf5
 1jkLt0Raa6VPLneL98iO6hOU2WXZOt4VZi7LwRfUh5bS96trNIJXAuSxTgwv6l1FWynWeK
 nynraNSlhzIkQhrKYe0OMpW12Hd+TM0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-V_1iiYxaPzG_49LoTUevbw-1; Tue, 22 Dec 2020 05:33:33 -0500
X-MC-Unique: V_1iiYxaPzG_49LoTUevbw-1
Received: by mail-pj1-f72.google.com with SMTP id 25so1050799pjb.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 02:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wB8MRQUpweKwq9jSQ8KUju/K937jhxEhC3XXMpTCHUk=;
 b=HxwiPzogTOJAxOKVrREXUNCnCC0BXzQeiJnYPsdSBsT+YP2BuSx4fwCgOax6BVYtTc
 +jbIzx7ItAiYS9F3lwcI5wt3LgIIVigrkz8uT4WmmZvlPrgXE/hmFFNXv17i83DWyDbj
 78Ua/fRDD0jykNTt4ezL7NyPa0dWEON5sa70qVoAogcOAxNInyDx4a2hUTElT8xNZSWV
 eJOhTfKGCCEDQwfJuXPiCMN5ZLdhzSm7RlFE/8SLUK08QuQH3uNDW+k500UiCefckLbg
 XmXmnyv/RO5TF+oJBRA4bAs9OTjPQW1iWvFfkOpzegTviamjAiVlN92j/eSC49CQsdoE
 ZnIg==
X-Gm-Message-State: AOAM531xHtegRDwdaGAWwHRE0iejFiwtYVvKuETMNKnUTzuUshUgnM7D
 8X/ngr0KcqPufraGl1xZtxqWRhrAIf4a1v65NcQBJT7LOKgA6KVE0IUVKWR3rloyX9jYPXNGLRD
 GRbbf7Ok4h0z9sI/4bfUkzQ5i
X-Received: by 2002:a17:90a:d148:: with SMTP id
 t8mr21475688pjw.126.1608633212174; 
 Tue, 22 Dec 2020 02:33:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmmJf2P2RpTFdHXUWnEZ8O5LAiZkaWVQ3UEcxKMLKFcrhzGI3eliGX53+moaz2Y80DiBtIIw==
X-Received: by 2002:a17:90a:d148:: with SMTP id
 t8mr21475663pjw.126.1608633211936; 
 Tue, 22 Dec 2020 02:33:31 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e21sm18371675pgv.74.2020.12.22.02.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 02:33:31 -0800 (PST)
Date: Tue, 22 Dec 2020 18:33:20 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222103320.GA1831635@xiangao.remote.csb>
References: <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
 <20201222093952.GC1819755@xiangao.remote.csb>
 <20201222174623.00005f9b.zbestahu@gmail.com>
 <20201222095906.GA1826582@xiangao.remote.csb>
 <20201222181751.00004a42.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201222181751.00004a42.zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

On Tue, Dec 22, 2020 at 06:17:51PM +0800, Yue Hu wrote:
> On Tue, 22 Dec 2020 17:59:06 +0800
> Gao Xiang <hsiangkao@redhat.com> wrote:
> 
> > On Tue, Dec 22, 2020 at 05:46:23PM +0800, Yue Hu wrote:
> > > On Tue, 22 Dec 2020 17:39:52 +0800
> > > Gao Xiang <hsiangkao@redhat.com> wrote:
> > >   
> > > > On Tue, Dec 22, 2020 at 05:30:14PM +0800, Yue Hu wrote:
> > > > 
> > > > ...
> > > >   
> > > > > > > 
> > > > > > >       
> > > > > > > > +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > > > > > > +			  erofs_fspath(path)) <= 0)      
> > > > > > > 
> > > > > > > The argument of path will be root directory. And canned fs_config for root directory as
> > > > > > > below:
> > > > > > > 
> > > > > > > 0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> > > > > > > 
> > > > > > > So, cannot add mount point to root directory for canned fs_config. And what about non-canned
> > > > > > > fs_config?      
> > > > > > 
> > > > > > Not quite sure what you mean. For non-canned fs_config, we didn't observed any strange
> > > > > > before (I ported to cuttlefish and hikey960 with boot success, also as I mentioned before
> > > > > > some other vendors already use it.)
> > > > > > 
> > > > > > I think the following commit is only useful for squashfs since its (non)root inode
> > > > > > workflows are different, so need to add in two difference place. But mkfs.erofs is not.
> > > > > > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > > > > > 
> > > > > > For root inode is erofs, I think erofs_fspath(path) would return "", so that case
> > > > > > is included as well.... Am I missing something?    
> > > > > 
> > > > > Yes, erofs_fspath(path) returns "" for root inode. However, the above patch add the mount
> > > > > point to fspath when specify it, so the real path is "vendor/" which does not exist in canned
> > > > > fs_config file. build will report below error:
> > > > > 
> > > > > failed to find [/vendor/] in canned fs_config    
> > > > 
> > > > Hmmm... such design is quite strange for me....  
> > > 
> > > :) i checked the squashfs before, seems root directory is handled in some position. Separated
> > > with sub directory fs_config. so i add the goto code in the 1st patch.  
> > 
> > What confuses me a lot is that we didn't get any strange without canned fs_config
> > if mount point prefix is added. I will look into other implementation about this
> > later (Another guess is that relates to Android 10 only?).
> 
> maybe relates to dynamic partition(intro from Android 10) which not be enabled by some vendors.

I think some of them use dynamic partition AFAIK, but might not be with QSSI
enabled (I'm not sure, anyway, that is minor...)

> 
> > 
> > Yeah, the opensource fs_config implementation might be different from HUAWEI
> > internal fs_config version since such part was not originally written by me and
> > I didn't pay more attention about this part when I was in my previous company.
> > But anyway, this cleanup opensource version is already used for some vendors
> > as well and I don't get such report... And any formal description about this
> > would be helpful for me to understand how fs_config really works..
> 
> Now i'm not familar with fs_config also :) I will continue to check when i have
> enough time.
> 
> Anyway, i observed the issue in canned fs_config since i'm using it. so i decide
> to report it and patch it to upstream to verify if it's a real one.

Yeah, that is somewhat bad and needs fixing if canned fs_config doesn't work
as expected...
My confusion for now is that how to deal with root dir properly (it seems
make_ext4fs doesn't even care about rootdir fs_config at all if my understanding
is correct.)

Also,
https://android.googlesource.com/platform/system/core/+/master/libcutils/fs_config.cpp
https://android.googlesource.com/platform/system/core/+/master/libcutils/canned_fs_config.cpp

are implemented quite different. So look forward to your test result (I tend
to add prefix for fs_config, but drop prefix for canned_fs_config instead.)

Thanks,
Gao Xiang

> 
> Thx.
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > >   
> > > > Could you try the following diff?  
> > > 
> > > Let's me verify.
> > >   
> > 
> 

