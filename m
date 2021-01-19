Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A682FBB7C
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 16:44:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKtHW6pY7zDqyq
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jan 2021 02:44:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=cbYIpbF0; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K142FKe6; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKtHD6KdyzDqv2
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Jan 2021 02:43:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611071028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRxoNPtIwD3VbuEDrU4ouZJ9Ujhp920qeoeEhhe1kCc=;
 b=cbYIpbF02cH6RhsG5VZVBmVR+W3iEE0z64Z5+olre8TpdyD/IBAExnSrzNKcA/QtpuaQCm
 36OFiuHdzOdZ1OE2IlIQ+K3EBobmDlV8sstEt6eHqcCwTEvNnIcVQQPkVuTUBAasdn7aaD
 ItbFMccCE7D00oEvnT5MOsNJx+rvgc4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611071029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRxoNPtIwD3VbuEDrU4ouZJ9Ujhp920qeoeEhhe1kCc=;
 b=K142FKe6Jhv3rlKlR3V1+cXkJzuyTMei9qffgV7JM1VLOU1y+vqzP9it4tWyzj44hg2p3q
 TZFaa0jmrgB8QZX0LFc2iaZ4Tmd6zBsu1u1TOTlO2RFpdPDj9SSm0TBjsjOw6VJ352bDrG
 tlISo52m7mAdVMqVhk0XptW64HfB8zU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-Trv5Mx3AO8WJbIRzlU7Ekg-1; Tue, 19 Jan 2021 10:43:46 -0500
X-MC-Unique: Trv5Mx3AO8WJbIRzlU7Ekg-1
Received: by mail-pj1-f71.google.com with SMTP id l7so184302pjg.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 07:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=RRxoNPtIwD3VbuEDrU4ouZJ9Ujhp920qeoeEhhe1kCc=;
 b=bjbVeHWNz+62vMAxM3RLXjJXXinBn8wvAMFFVfabxvkc9CG0EsSAAZL2E9JqT0A2t1
 wD5rnbvvVpLAlAP21IPZJL9itJ37n+OJ2gQ7vJ+n+KYBzS4F2uMkUehMU0D1f4Wm9wsI
 44Jzl4OpMYnolvs/xF7Yoltfn37Y0ye/1EoaPrRo0tulPprc9/63rhXdjIKrHQ9eAlor
 ORAKwfx2Q0t0ySFFgExB8R47zpS5h4Z3o1YfxQFXJseJ9UyuLcR/1Y5pkvkopVCEiFbW
 5OyJys8jumoW0dJh6ihw675Gx4aA5NQdMvG+ODDfExb3alBAhwW2hHbmEEIjNp14KHB/
 ueiw==
X-Gm-Message-State: AOAM530QkXdgtN2it5q1FAtzgitwTrqrGkiSEmplxMxH9onfVibiJcBE
 irENlE6GnLV3YzUr/VOenccQ5d6naQ/npZhqql9Jgz4wmhrklZOym0cfoGdmgpb5cAVMWId5Ykb
 lJZWamppMo/S3dLb/jh851XUF
X-Received: by 2002:a63:1315:: with SMTP id i21mr4894039pgl.370.1611071025456; 
 Tue, 19 Jan 2021 07:43:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWOoLbPuhg3l8mqWNXk9phz8DLNH6OGl3JKLL8EBOX+1s/XjT2Y5qsG8Nz1idmtxisxa06mQ==
X-Received: by 2002:a63:1315:: with SMTP id i21mr4894025pgl.370.1611071025228; 
 Tue, 19 Jan 2021 07:43:45 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t4sm19252969pfe.212.2021.01.19.07.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 07:43:44 -0800 (PST)
Date: Tue, 19 Jan 2021 23:43:35 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Message-ID: <20210119154335.GB2601261@xiangao.remote.csb>
References: <20210118123945.23676-1-sehuww@mail.scut.edu.cn>
 <20210118135916.GB2423918@xiangao.remote.csb>
 <20210119060256.GA7664@DESKTOP-N4CECTO.huww98.cn>
MIME-Version: 1.0
In-Reply-To: <20210119060256.GA7664@DESKTOP-N4CECTO.huww98.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hi Weiwen,

On Tue, Jan 19, 2021 at 02:02:56PM +0800, 胡玮文 wrote:
> Hi Xiang,
> 
> After further investgate, this bug will not reveal in any released version of
> mkfs.erofs. Previous patch v5 [1] will map all allocated bb when erofs_mapbh()
> is called on an already mapped bb, which triggers this bug. before that patch,
> under the same condition, __erofs_battach() will only be called on bb which is
> not mapped, thus no need to update `tail_blkaddr'.

Good to know this, thanks! I haven't looked into that (I will test it this
weekend.) IMO, although this is not a regression, yet it seems it's potential
harmful if we didn't notice this... So I think a proper testcase is still
useful to look after this... If you have extra time, could you help on it?

Also, without the detail of this, I think the fix might be folded into
the original patchset (could you resend it?). In addition, I think after
last_mapped_block is introduced, we might not need tail_blkaddr anymore,
not sure. But I'm very cautious about this in case of introducing any
new regression...

Thanks,
Gao Xiang

> 
> [1]: https://lore.kernel.org/linux-erofs/20210118123431.22533-1-sehuww@mail.scut.edu.cn/
> 
> Hu Weiwen
> 

