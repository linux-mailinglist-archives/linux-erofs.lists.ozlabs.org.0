Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B103F4191AD
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Sep 2021 11:39:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HHyJm5R7Zz2yNq
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Sep 2021 19:39:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=CQILzEC7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=szeredi.hu (client-ip=2a00:1450:4864:20::52a;
 helo=mail-ed1-x52a.google.com; envelope-from=miklos@szeredi.hu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="key not found in DNS" header.d=szeredi.hu
 header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=CQILzEC7; 
 dkim-atps=neutral
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HHyJc6zXFz2yM7
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Sep 2021 19:39:09 +1000 (AEST)
Received: by mail-ed1-x52a.google.com with SMTP id x7so51983807edd.6
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Sep 2021 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ECuwL8PYjygsXbJeg0HIr0JMSqu9hGq4/KV9n5A6dtA=;
 b=CQILzEC7pzKjk9XO7pFtNfZ/7DXYnBmKVK4NBNhCa1P8Ky74nwcKlLrArJ/RA4o5Ee
 BPMosUGfUDgE+agrVRTsixyT/PB+0Vaa6wqVMRoRrYxCvhAN1UHuWbpBgYjqE04C28Lt
 xolW6ymtZCXimpknOdvLPeKaUTjEyYKUfIGdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ECuwL8PYjygsXbJeg0HIr0JMSqu9hGq4/KV9n5A6dtA=;
 b=OLTm92EDec+KXRalpEFlzWfQYrBLwOhQn8zd6TBJ5ox32NxKCsYopzohYXFtruk1H5
 nS0zHPF4+V+OyxCaeNkxUVJlpileH6VnY9yV+GjcCjGJJTt/VBqHjdZ/5X8CyDVdx4OX
 wSHpXdSIvaVm3xShjRCIvA1n0d9JJP97RdAI2AvOcJhn+r3xXJN16iJ1yE4rYTjiBAyG
 c46o0anX630dQYj5DKfAbZK+VZ8cvgK9ksvY4I73NqRZKbo5Xk5hkWrUPLFVOJGV0eW9
 W8ngKhA57KsuxTb9Q84pSY7m+1H8AVmqpPZJFI/PrV1WulFSkzzhulDphBrrnrRedDHY
 l46w==
X-Gm-Message-State: AOAM533254FM+hjsSeRsZxgDxsnA+cbFKi7BqEZd7lA3pXtLtaXHdLXU
 BxV7cDIywiMTtLMs6aLTvEsF+Q==
X-Google-Smtp-Source: ABdhPJzW+RfuYCPBrlZd1XY3JCu+cCPxlJ0MUR8DYD5oqwXxw7pJMF2ZzojlsotC6zZLslQ5r2B7Wg==
X-Received: by 2002:a17:906:e216:: with SMTP id
 gf22mr25286699ejb.357.1632735541800; 
 Mon, 27 Sep 2021 02:39:01 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com
 (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
 by smtp.gmail.com with ESMTPSA id dt4sm3169554ejb.27.2021.09.27.02.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 02:39:01 -0700 (PDT)
Date: Mon, 27 Sep 2021 11:38:58 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v3] ovl: fix null pointer when
 filesystemdoesn'tsupportdirect IO
Message-ID: <YVGRMoRTH4oJpxWZ@miu.piliscsaba.redhat.com>
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
 <20210922072326.3538-1-huangjianan@oppo.com>
 <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
 <919e929d-6af7-b729-9fd2-954cd1e52999@oppo.com>
 <314324e7-02d7-dc43-b270-fb8117953549@139.com>
 <CAJfpegs_T5BQ+e79T=1fqTScjfaOyAftykmzK6=hdS=WhVvWsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs_T5BQ+e79T=1fqTScjfaOyAftykmzK6=hdS=WhVvWsg@mail.gmail.com>
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org,
 overlayfs <linux-unionfs@vger.kernel.org>,
 Chengguang Xu <cgxu519@mykernel.net>, yh@oppo.com, guanyuwei@oppo.com,
 linux-fsdevel@vger.kernel.org, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, Chengguang Xu <cgxu519@139.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 22, 2021 at 04:00:47PM +0200, Miklos Szeredi wrote:

> First let's fix the oops: ovl_read_iter()/ovl_write_iter() must check
> real file's ->direct_IO if IOCB_DIRECT is set in iocb->ki_flags and
> return -EINVAL if not.

And here's that fix.  Please test.

Thanks,
Miklos

---
From: Miklos Szeredi <mszeredi@redhat.com>
Subject: ovl: fix IOCB_DIRECT if underlying fs doesn't support direct IO

Normally the check at open time suffices, but e.g loop device does set
IOCB_DIRECT after doing its own checks (which are not sufficent for
overlayfs).

Make sure we don't call the underlying filesystem read/write method with
the IOCB_DIRECT if it's not supported.

Reported-by: Huang Jianan <huangjianan@oppo.com>
Fixes: 16914e6fc7e1 ("ovl: add ovl_read_iter()")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -296,6 +296,12 @@ static ssize_t ovl_read_iter(struct kioc
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    (!real.file->f_mapping->a_ops ||
+	     !real.file->f_mapping->a_ops->direct_IO))
+		goto out_fdput;
+
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	if (is_sync_kiocb(iocb)) {
 		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
@@ -320,7 +326,7 @@ static ssize_t ovl_read_iter(struct kioc
 out:
 	revert_creds(old_cred);
 	ovl_file_accessed(file);
-
+out_fdput:
 	fdput(real);
 
 	return ret;
@@ -349,6 +355,12 @@ static ssize_t ovl_write_iter(struct kio
 	if (ret)
 		goto out_unlock;
 
+	ret = -EINVAL;
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    (!real.file->f_mapping->a_ops ||
+	     !real.file->f_mapping->a_ops->direct_IO))
+		goto out_fdput;
+
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
 
@@ -384,6 +396,7 @@ static ssize_t ovl_write_iter(struct kio
 	}
 out:
 	revert_creds(old_cred);
+out_fdput:
 	fdput(real);
 
 out_unlock:
