Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D02FE642
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 10:23:27 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLxlH5Kq8zDrBJ
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 20:23:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=PE/GlfsJ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PE/GlfsJ; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLxl42Vl7zDr88
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 20:23:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611220988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxTp0qJS2vuecc8jau3OGxxutWJCeFtDfPDwv+vRlZo=;
 b=PE/GlfsJGRlpWtgLwP1N/SKVjBEYLwdjrrY44vSDMBnZdfm3kYQK/g05Q4tHGqtIBVaWE1
 6yQMLIoyR+TXkCpP0TEvzLp3WTGh9sQb9izNtDu2dTgjcXSdVhsjKHAWRDRYjfbJvttMLb
 IWywg4MFIM9qJLESxfeF82U0BzUZdhE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611220988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxTp0qJS2vuecc8jau3OGxxutWJCeFtDfPDwv+vRlZo=;
 b=PE/GlfsJGRlpWtgLwP1N/SKVjBEYLwdjrrY44vSDMBnZdfm3kYQK/g05Q4tHGqtIBVaWE1
 6yQMLIoyR+TXkCpP0TEvzLp3WTGh9sQb9izNtDu2dTgjcXSdVhsjKHAWRDRYjfbJvttMLb
 IWywg4MFIM9qJLESxfeF82U0BzUZdhE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-gqczSF5OPAKKWujZ1fRRvg-1; Thu, 21 Jan 2021 04:23:05 -0500
X-MC-Unique: gqczSF5OPAKKWujZ1fRRvg-1
Received: by mail-pj1-f71.google.com with SMTP id lr5so5981322pjb.1
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 01:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=IxTp0qJS2vuecc8jau3OGxxutWJCeFtDfPDwv+vRlZo=;
 b=cQeitniyFgLscE7Nt/mXl+rQXq98IvfnW9/opi2JsY2Xss80ERbD9hP0N5EelU7VCh
 +qEYVU/iTmUGb1+EaPRWSehtYXzN1WSAPAx4tCw1y/6g4Kq2BL/HppmaZ0no0hyA+DE5
 lXin9zbIxnV2fYy9JyB56xyJnCgZhDr8dkQcu2v9r+BVcelDRItOhWm0ZdXtMjbwjAaY
 SheVzRHkLJaZzdgEFbXJZz4RgfWPBVXu8ehq3qm4CKlvTQX0uYJcza86EOUTv5Hd3sr0
 kARWpTXvoBoaxOdwVd99TDlo6K4SH/tC7tmFCuLPKwJpFen4JrGuRlUlMF7zSX564SS7
 gOAA==
X-Gm-Message-State: AOAM530TY23ZBJOjQ3KR+JgV+URQVi86Y1BcPZTfg3fg6hsmBcO7j+8L
 GUOJuxZPekgqTxgsRDf4sLb03rB1j1WN+ipYx6wQGmkBfc3PGOcq+Y0M9E4Zc6EQabRWdALEmxV
 Bo8wtIy5+hb4hUqbqLG1Kp5ay
X-Received: by 2002:a17:902:bc41:b029:de:1ec2:dac1 with SMTP id
 t1-20020a170902bc41b02900de1ec2dac1mr14225792plz.9.1611220984585; 
 Thu, 21 Jan 2021 01:23:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxywcpWSXklrmK/LsEl9Hq5KF0IC9pnz/272XQmTh9+pR+lBU6aFk0+1a1B7zxo9NeVEPgvTQ==
X-Received: by 2002:a17:902:bc41:b029:de:1ec2:dac1 with SMTP id
 t1-20020a170902bc41b02900de1ec2dac1mr14225774plz.9.1611220984302; 
 Thu, 21 Jan 2021 01:23:04 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c8sm3855681pfo.148.2021.01.21.01.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 01:23:03 -0800 (PST)
Date: Thu, 21 Jan 2021 17:22:54 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Message-ID: <20210121092254.GA2902889@xiangao.remote.csb>
References: <20210119154335.GB2601261@xiangao.remote.csb>
 <32A61DA5-EED5-4268-B6C5-CAAB94527F91@mail.scut.edu.cn>
 <20210120051216.GA2688693@xiangao.remote.csb>
 <20210121060738.GA6680@DESKTOP-N4CECTO.huww98.cn>
MIME-Version: 1.0
In-Reply-To: <20210121060738.GA6680@DESKTOP-N4CECTO.huww98.cn>
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

On Thu, Jan 21, 2021 at 02:07:38PM +0800, 胡玮文 wrote:

...

> 
> I've downloaded "tests/results/" and it's test 007 (check for bad lz4 versions)
> that fails with output "test LZ4_compress_HC_destSize(1048576) error (4098 <
> 4116)". And it's the same error on my PC. Investigating.
> 
> BTW, why not use a more meaningful name for each test rather than a sequence
> number?

I'm not good at English naming (but such cases need stable names),
also see xfstests:
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/xfs
the meaningful description can be written down at tests/Makefile.am... 

Yet they have no interest in integrating such testcases (also generic/
cases are not useful for EROFS either), and EROFS has many specific
optimized paths so I decided to make a light-weight regression
testcases in erofs-utils to look after it and kernel EROFS...

Thanks,
Gao Xiang

> 
> Hu Weiwen

