Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1262FE8B8
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 12:27:49 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DM0Vm4wQQzDrQ4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 22:27:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=gqox7HOV; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gqox7HOV; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DM0VJ4nTWzDqXJ
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 22:27:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611228436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIRkDM8WE1SDwdmPI7uZMuXC2/NJcZEZ9ju+GijGymU=;
 b=gqox7HOV4YPXnC6VU+LKyYLiFC0qyAkrp07R1eX6l+FETwsKKui4SnQrw+2bylH0RRPhh6
 eO4Dl/p9QL4L6Q9e03Zz0arrdvNhBEA6N3S1jTMbBDEW8BIKH1icHXQ0iG2NDSagYgDIbv
 TQN1IQcXWKwD2TDUddDdZ1VApDyaPdY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611228436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIRkDM8WE1SDwdmPI7uZMuXC2/NJcZEZ9ju+GijGymU=;
 b=gqox7HOV4YPXnC6VU+LKyYLiFC0qyAkrp07R1eX6l+FETwsKKui4SnQrw+2bylH0RRPhh6
 eO4Dl/p9QL4L6Q9e03Zz0arrdvNhBEA6N3S1jTMbBDEW8BIKH1icHXQ0iG2NDSagYgDIbv
 TQN1IQcXWKwD2TDUddDdZ1VApDyaPdY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-8dukxXXlPr6_NAKeKsI6oA-1; Thu, 21 Jan 2021 06:27:14 -0500
X-MC-Unique: 8dukxXXlPr6_NAKeKsI6oA-1
Received: by mail-pj1-f70.google.com with SMTP id hg20so1352174pjb.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 03:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=uIRkDM8WE1SDwdmPI7uZMuXC2/NJcZEZ9ju+GijGymU=;
 b=XaQ1HHMvn7zVZiTcuIpmFq/7cvvK6QnY6GgPAc8apApPdLfDIWwE1r1jvc4lDVlJ3G
 CIJMHSqrkX7Z9ymXlRHjYQJODbg3DbnH3RpVTXXJ3v5GMZ1cHQNVyeIieb7KAWO7LlFc
 u11p5/83aaC3JXjPFLwZMabvpZxXcIGUf5IITwpgOe7Eif4jfKQin38JcR6jRITdphXl
 qA1fk/LlGFm0dDHh36V8a3nAo+DZVgjDR74dxeJuzSSWt4WSYBr1YnU7d7S3xCrpymZo
 oIVUzILAcOeFQXSOJzlAAkPoTFpSYrM7Zez+0LAzSD9sL+htocNBHRR3LiNVJ1K5zG8h
 HOYQ==
X-Gm-Message-State: AOAM533fVj6g9+VbS28QrpsgKmnWMBkkyq8zxB+6/tnZKZWVlouMrfwg
 7AYgfzV3paMGpYAl8EM/E01cgqud4fS0YIfW4lImk90EHBaTU2Unt9JkKJbDz9kHx6mxxapX0/W
 +HBdCyHz52ja7YlUjmLoTDCnd
X-Received: by 2002:a63:cd08:: with SMTP id i8mr13927227pgg.425.1611228433796; 
 Thu, 21 Jan 2021 03:27:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWX7JZrWYnDjZyQTTK0arYajzcQUKsV+s8LZPaftDL/ft+G7RSlXvuXMrToUJ4S+bilKVyMA==
X-Received: by 2002:a63:cd08:: with SMTP id i8mr13927204pgg.425.1611228433449; 
 Thu, 21 Jan 2021 03:27:13 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y22sm5371421pfr.163.2021.01.21.03.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 03:27:12 -0800 (PST)
Date: Thu, 21 Jan 2021 19:27:02 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: fuse returns ENOENT to openat() for symlink probabilistically
Message-ID: <20210121112702.GA2918836@xiangao.remote.csb>
References: <20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn>
MIME-Version: 1.0
In-Reply-To: <20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn>
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

(add Jianan in case that he has some interest as well)

On Thu, Jan 21, 2021 at 06:12:33PM +0800, 胡玮文 wrote:
> Hi all,
> 
> I'm working on setting up CI service to run tests automatically. Now I have got
> tests with kernel mount succeeded. But some tests with fuse fails
> probabilistically. Here are my discoveries:
>

If you have some interest, it would be better to add '-d' to
erofsfuse to print the debug message when reproduing that,
if that is not enough we might need to add more debug messages
(just using fprintf is enough since it's MT-safe.)

I will checked this case this weekend as well.

> * if I run fssum in tests/src from experimental-tests branch multiple times, it
> returns different checksums for the same image and same erofsfuse process.
> 
> * if I run "diff -r" on the source and the mounted directories, all file
> content matches. but sometimes, diff reports "diff:
> test-mount/lib/.libs/liberofs.la: No such file or directory". This file is a
> symlink to "../liberofs.la". Then I use strace to confirm that openat() system
> call to this path returned ENOENT incorrectly. strace outputs:
> 
> openat(AT_FDCWD, "test-mount/lib/.libs/liberofs.la", O_RDONLY) = -1 ENOENT (No such file or directory)
> 
> * However, If I just do "cat test-mount/lib/.libs/liberofs.la" several hundreds
> of times, I cannot trigger this issue.
> 
> * I can reproduce this on both compressed and uncompressed images.
> 
> There seems a race condition, but I cannot figure it out. I'm not familiar with
> fuse. But I would like to debug further if someone can provide me any advice or
> guidance.

Not sure if this is a race condition (or not), since currently erofsfuse
itself is implemented statelessly (so no need to add more MT-safe protect
in principle). I'm afraid that could be something wrong somewhere (which
seems somewhat as stale VFS negative dentries, yet not sure why it behaves
as this...)

Thanks,
Gao Xiang

> 
> Thanks,
> Hu Weiwen
> 

