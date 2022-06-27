Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404A55B7DE
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Jun 2022 07:57:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LWcSG1QvPz30Hf
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Jun 2022 15:57:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Oe5p1iAB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Oe5p1iAB;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LWcS827whz2xKx
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Jun 2022 15:56:55 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so601855pjs.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jun 2022 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgGjIZMQi9zPseLwcTQISWkTzjFMEgBUdyAykEEFOv4=;
        b=Oe5p1iABnBF6/fGExyGi30NSTjr0bFRYVqoTFnPu8qX2eqlenGsnAn0GVMY7RoiFCc
         TCHYmxJL9UTUONyirC5ImxBG0EY+OtKWQ9aTVou4alzG0aMUkw/y2wPw37iu4wf1yiFb
         zB4i5Z/bZ2dBXyX6eqbDo6kRDhlL/DAzAKZmr/jI8rtJqilhfNuOUUmy5YjWTcKKxNBi
         kI7vexDUTEuWWNDgwe2VBFI0qaJ89i9OlgPndoDRyuQCStteqQixg/k+9DExmwwddfZv
         BULKUBRq5dE1E1HyEbU/UFLm5BKD68T0ecMggiTU/YQ1FxrjvIEvmOt0kx8P+iLjmbm8
         nXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgGjIZMQi9zPseLwcTQISWkTzjFMEgBUdyAykEEFOv4=;
        b=DcH7yJB4sL4voaFY3Tn6D0E61cA3poHvNVRQ31NxyxxTeKXphMYczhdUQgYJ+4NnyO
         7DyvkTMAY8BLUe810er0Ykk5s6Opvr6K2q8kJ7ZSfzPBE93m3j91PGoWw56j4xKYjVid
         Ck2apgDyrSglMWWjbXMO1vcyrJ6Tk52e+hsezp8sSh0a/HDSVpGElzC1Nu1eyMFcn3ad
         uATkQnL4GQLZmfcN0f/eRyAEpdLXmw6CbJL2qycDDPuAexjm9m60KV7R3L0U9FcCn3+Y
         MeXnktUhlVxdwSjBOhZyT2a+csmvvxKavDvdt9ZTUzdpFSfLiH06fzpztmo9OJoYnsaW
         yk4w==
X-Gm-Message-State: AJIora8/uk1UGqOC9n2pDh6SOSi6Xx257exB/mwqFyS62NrO5LdXQ1R6
	khetZRcSYDlKPAut9tvj8X0=
X-Google-Smtp-Source: AGRyM1t1CnaacjaxbLUAI3PrusjR5hzrugJjX/H7Hvul4kfHgGqFr8fI3YMelLlcYjowRPox0/UqlQ==
X-Received: by 2002:a17:902:c401:b0:16a:1873:5ca3 with SMTP id k1-20020a170902c40100b0016a18735ca3mr12713755plk.157.1656309411898;
        Sun, 26 Jun 2022 22:56:51 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b0016a100c9a2esm6167713pln.112.2022.06.26.22.56.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jun 2022 22:56:51 -0700 (PDT)
Date: Mon, 27 Jun 2022 13:57:54 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Yuwen Chen <chenyuwen1@meizu.com>
Subject: Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head
 ready.
Message-ID: <20220627135754.00000999.zbestahu@gmail.com>
In-Reply-To: <20220625145000.2720-1-chenyuwen1@meizu.com>
References: <20220625145000.2720-1-chenyuwen1@meizu.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, 25 Jun 2022 22:50:00 +0800
Yuwen Chen <chenyuwen1@meizu.com> wrote:

> When the user mounts the erofs second times, the decompression thread
> may hung. The problem happens due to a sequence of steps like the
> following:
> 
> 1) Task A called z_erofs_load_lzma_config which obtain all of the node
>    from the z_erofs_lzma_head.
> 
> 2) At this time, task B called the z_erofs_lzma_decompress and wanted to
>    get a node. But the z_erofs_lzma_head was empty, the Task B had to
>    sleep.
> 
> 3) Task A release nodes and push nodes into the z_erofs_lzma_head. But
>    task B was still sleeping.
> 
> One example report when the hung happens:
> task:kworker/u3:1 state:D stack:14384 pid: 86 ppid: 2 flags:0x00004000
> Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> Call Trace:
>  <TASK>
>  __schedule+0x281/0x760
>  schedule+0x49/0xb0
>  z_erofs_lzma_decompress+0x4bc/0x580
>  ? cpu_core_flags+0x10/0x10
>  z_erofs_decompress_pcluster+0x49b/0xba0
>  ? __update_load_avg_se+0x2b0/0x330
>  ? __update_load_avg_se+0x2b0/0x330
>  ? update_load_avg+0x5f/0x690
>  ? update_load_avg+0x5f/0x690
>  ? set_next_entity+0xbd/0x110
>  ? _raw_spin_unlock+0xd/0x20
>  z_erofs_decompress_queue.isra.0+0x2e/0x50
>  z_erofs_decompressqueue_work+0x30/0x60
>  process_one_work+0x1d3/0x3a0
>  worker_thread+0x45/0x3a0
>  ? process_one_work+0x3a0/0x3a0
>  kthread+0xe2/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>  </TASK>
> 
> Signed-off-by: Yuwen Chen <chenyuwen1@meizu.com>
> ---
>  fs/erofs/decompressor_lzma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 05a3063cf2bc..5e59b3f523eb 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -143,6 +143,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
>  	DBG_BUGON(z_erofs_lzma_head);
>  	z_erofs_lzma_head = head;
>  	spin_unlock(&z_erofs_lzma_lock);
> +	wake_up_all(&z_erofs_lzma_wq);
>  
>  	z_erofs_lzma_max_dictsize = dict_size;
>  	mutex_unlock(&lzma_resize_mutex);

Please do not end the summary line(title) with a period.
