Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE142E242A
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Dec 2020 05:20:18 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D1cLQ294gzDqLB
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Dec 2020 15:20:14 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=eEjP37TF; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eEjP37TF; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D1cLM6G8XzDqGm
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Dec 2020 15:20:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608783607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzlJTlJgzBELU8ClDUNMI4TFHAn5DSdM2cVPgaLmtgw=;
 b=eEjP37TFJ5HcbtObbVGWitxYADoE2qoxrz1ujwTTp0QLYAsiu7Zwpk3n42a/v++O0DR4LL
 by73hfP3U6DuI+uRWKtgyMVdDVpliMlHIIeeBvyN4jMGMbRaykfP5ZT9tEO6dNlttSqrRl
 r9PLFdtVfZV4zF1XTucC4bl+f+9iAMM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608783607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzlJTlJgzBELU8ClDUNMI4TFHAn5DSdM2cVPgaLmtgw=;
 b=eEjP37TFJ5HcbtObbVGWitxYADoE2qoxrz1ujwTTp0QLYAsiu7Zwpk3n42a/v++O0DR4LL
 by73hfP3U6DuI+uRWKtgyMVdDVpliMlHIIeeBvyN4jMGMbRaykfP5ZT9tEO6dNlttSqrRl
 r9PLFdtVfZV4zF1XTucC4bl+f+9iAMM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-0Z25V7dJPb6wrOVcN3jn0A-1; Wed, 23 Dec 2020 23:20:05 -0500
X-MC-Unique: 0Z25V7dJPb6wrOVcN3jn0A-1
Received: by mail-pf1-f199.google.com with SMTP id y187so731306pfc.7
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 20:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RzlJTlJgzBELU8ClDUNMI4TFHAn5DSdM2cVPgaLmtgw=;
 b=beYtO6E2zrpmqbUDfieMvV0LYa0y6/tbybCyHi2Oc8BsgMhQB5+HHRUdO2y3p8ZKq8
 O5YzEp8Hf+VRw2gHFvSeezfZyxzJXcf9mixhplpYGtugn5zuaMt4/Qk0/gDppkVufuSJ
 npvvKoKpYK/0XwvDlrq8aEs6AIlArAS2d+JeECCu4osf32ek2P/dv+GoJrKLCsXKbMlI
 EMvKAoCfI+PIBUf8g6/NH+ndEeyyBloxs1dhge2niNlybKlUj7VVk0oePrhE74ueSl9Z
 u/idjXSYrMkC2YqJ/43Y92k2UiJ2odqYNKz7GzCwI9KgfidRFabomwG4vqRcGIVYV1Rd
 wY5w==
X-Gm-Message-State: AOAM530xdzpm9j4kjH6oBaDm11C8xuuXrSpup+OzIcSx2dRUQcU917pJ
 ETVNn6RAgzl1Pq9xqLA8QvTb7K2Hhvea3OS7WUlL/zfHeVdTRw0xIssrLRvZ2/ipYaEClo0t6XL
 bRZzJij/2D2atfJY8/qfqz3C/
X-Received: by 2002:a63:e41:: with SMTP id 1mr27224344pgo.195.1608783604273;
 Wed, 23 Dec 2020 20:20:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgyAjZknI++J8hY2pFCuzaFUfFQeK7A/PbpKG3bfA0VubJ8y/k830HmcIiFzww5L48F16Rsg==
X-Received: by 2002:a63:e41:: with SMTP id 1mr27224321pgo.195.1608783603869;
 Wed, 23 Dec 2020 20:20:03 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b129sm23269347pgc.52.2020.12.23.20.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 20:20:03 -0800 (PST)
Date: Thu, 24 Dec 2020 12:19:51 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201224041951.GA2140248@xiangao.remote.csb>
References: <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
 <20201222093952.GC1819755@xiangao.remote.csb>
 <20201222183411.00004854.zbestahu@gmail.com>
 <20201222104700.GB1831635@xiangao.remote.csb>
 <20201224114542.0000461f.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201224114542.0000461f.zbestahu@gmail.com>
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
Cc: huyue2@yulong.com, xiang@kernel.org, linux-erofs@lists.ozlabs.org,
 zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Thu, Dec 24, 2020 at 11:45:42AM +0800, Yue Hu wrote:
> On Tue, 22 Dec 2020 18:47:00 +0800
> Gao Xiang <hsiangkao@redhat.com> wrote:
> 

...

> > > Works for me for canned fs_config.  
> > 
> > Ok, if it also works fine for non-canned fs_config on your side,
> > I will redo a formal patch later... sigh :(
> 
> Hi Xiang,
> 
> I just remove the "--fs-config-file" in my test enviroment, after that,
> build and boot are all working fine. 
> 
> If canned fs_config never used by others before, i think it's a bug. 

Thanks for your report. I agree with your conclusion. Let me seek some
extra free time later to form a formal patch and test on my PC then.

I'll finish this this week, don't worry :)

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
> > > Thx.  
> > 
> 

