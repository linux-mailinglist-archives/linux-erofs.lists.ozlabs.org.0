Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13E2BC3A3
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 05:59:02 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cdyjv5LjDzDqZw
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 15:58:59 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=LvWR3ofL; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oyd+ziQ9; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cdyjm5HylzDqZV
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Nov 2020 15:58:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606021122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsKbCDpOedfl24aTC7QEWvFhjCFNNJAXmiQtgluDhcU=;
 b=LvWR3ofLcdKrKFUF0bevCnhe/DSH30xXdpgbLCPiKZbcHc1SRX6haOgiYtpSMODlX/SYeL
 zcW91QqeGrEjnIJnGwuzUsKv6JywFOyuEEi3wrG3/mGjpQhMk/652QsrS4WrH0MSiIgshK
 LKKNZ8UTe13FGJC82cKCQYbqobjxzh0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606021123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsKbCDpOedfl24aTC7QEWvFhjCFNNJAXmiQtgluDhcU=;
 b=Oyd+ziQ9wp2TbcVcYB8K2tTda7kbov6a9Lu16aMQwsb3xGI9A+XtEHb2qtqZDjtQ/EHZ0Z
 Kzzv/IW3uQDqE56Ytdb4PHGbv5xOsGB/2U+2UBXdTN2ZEL9+gGW2D6iTQTuIIMmAEbLzMa
 HtGQzuMJbDCbwKPxqR/k13EvN4BBAj8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-627eEcilPr6lgVGLUrr4qw-1; Sat, 21 Nov 2020 23:58:40 -0500
X-MC-Unique: 627eEcilPr6lgVGLUrr4qw-1
Received: by mail-pl1-f198.google.com with SMTP id x11so9188989plv.7
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 20:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lsKbCDpOedfl24aTC7QEWvFhjCFNNJAXmiQtgluDhcU=;
 b=qP74lzOvnZw8mQjlw9l/H9KJ6nyp08FMGEap9z3pH9o0USd5ORb3KFNf3G4PmrXyxf
 Ta8iWRgJonL3dcHrOdpK9kJsEUqfiORf9foeGvtYtyEr4R+kZy66aQutactAla8Ybeeh
 XoEWH7y4FbFjxZBg+Zy+9At5Ub7gvLIpms+o7oA38z8DXm/S11YGTpZWkb5h25L8oM/j
 WK6E7azmTUC3/DiiX606x4bA4MPvxO9JnW90G08L5WAzDCk9+2EiDgfm9M59b9rEf+hz
 SJeAOK5AI9G0Ckz5RVtNISC+1sdAb8KX9Ll7tLuz9JLLQuRLNPLe1gw6yD3Kzc74Zkbi
 LXrg==
X-Gm-Message-State: AOAM533/oXZ/2ccrW/x6c5jIjUfUWiDsPCF7aIMcLMeVpCvqws8PeLtJ
 gsBD5l4uJ7JQWpUjgiRc9p4MVgJalNJ41ggXcEu4zc9DJiGqe2YJm8e4BPN1WAQ6AUudNYcHlS+
 XC6/wQDGqoSkoWr3hm9TVTDPI
X-Received: by 2002:a63:eb11:: with SMTP id t17mr23503940pgh.286.1606021119284; 
 Sat, 21 Nov 2020 20:58:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrY0/mrCxR4WedeEH4imc24veLBTP9caTvpzG4FQPHETGfsNjBgxpUdTudQ4NTK86Owsnmmg==
X-Received: by 2002:a63:eb11:: with SMTP id t17mr23503929pgh.286.1606021118924; 
 Sat, 21 Nov 2020 20:58:38 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l8sm8935626pjq.22.2020.11.21.20.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2020 20:58:38 -0800 (PST)
Date: Sun, 22 Nov 2020 12:58:27 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH 1/3] erofs-utils: introduce fuse implementation
Message-ID: <20201122045827.GA2715896@xiangao.remote.csb>
References: <20201120174146.18662-1-hsiangkao@aol.com>
 <20201120174146.18662-2-hsiangkao@aol.com>
 <8c768a92-3126-006c-1272-8c8022e8c792@aliyun.com>
MIME-Version: 1.0
In-Reply-To: <8c768a92-3126-006c-1272-8c8022e8c792@aliyun.com>
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
Cc: linux-erofs@lists.ozlabs.org, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Nov 22, 2020 at 12:43:31PM +0800, Li GuiFu via Linux-erofs wrote:
> Gao Xiang
> 
> It run good, some codes format need to be adjusted
> Please re-send to make more readable

Thanks for taking time on this, I also think it might be worth
adding some testcase coverage for erofsfuse later. Let me think
more about this.

> 
> On 2020/11/21 1:41, Gao Xiang via Linux-erofs wrote:
> > From: Li Guifu <blucerlee@gmail.com>
> > 
> > Let's add a simple erofsfuse approach, and benefits are:
> > 
> >  - images can be supported on various platforms;
> >  - new unpack tool can be developed based on this;
> >  - new on-disk features can be iterated, verified effectively.
> > 
> > This commit only addresses reading uncompressed regular files.
> > Other file (e.g. compressed file) support is out of scope here.
> > 
> > Note that erofsfuse is an unstable feature for now (also notice
> > LZ4_decompress_safe_partial() was broken in lz4-1.9.2, which
> > just fixed in lz4-1.9.3), let's disable it by default for a while.
> > 
> > Signed-off-by: Li Guifu <blucerlee@gmail.com>
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> > ---
> 
> > +
> > +static void signal_handle_sigsegv(int signal)
> > +{
> > +	void *array[10];
> > +	size_t nptrs;
> > +	char **strings;
> > +	size_t i;
> > +
> > +	erofs_dump("========================================\n");
> > +	erofs_dump("Segmentation Fault.  Starting backtrace:\n");
> > +	nptrs = backtrace(array, 10);
> > +	strings = backtrace_symbols(array, nptrs);
> > +	if (strings) {
> > +		for (i = 0; i < nptrs; i++)
> > +			erofs_dbg("%s", strings[i]);
> 
> erofs_dbg change to erofs_dump to make all log printed, "\n" is needed

Will fix.

> 
> > +		free(strings);
> > +	}
> > +	erofs_dump("========================================\n");
> > +	abort();
> > +}
> > +
> > +
> 
> >  
> > +static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
> > +					  unsigned int bits)
> > +{
> > +

> empty line is not needed

Ah, will fix. which was copied from the kernel side, these two empty
lines can be deleted for sure (If you are interested in it, could you
also take a look at cleaning up _all_ reduntant extra line on the on
the kernel side as well, it's minor though.)

> 
> > +	return (value >> bit) & ((1 << bits) - 1);
> > +}
> > +
> > +
> empty line is not needed

ditto.

Thanks,
Gao Xiang

