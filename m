Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 088608D706
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 17:15:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467tRr5gXRzDqsl
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2019 01:15:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565795704;
	bh=cHKdDElY7U0Y7dC1vqm5HaCw6EuTShMpnzjMJvrzeDw=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=m9+k+Ih3YfF2nzAnz5nJ8f+8GpSHPS4F2opqkgOGJbXKhTJcK/Y0WWnA+dh3khgu/
	 LY/UdqJ8XE8+8EOPMoVMurC5UAPNIOxj5VDm74YUMh7F8fz9K5qhzqX+cVkKPUdl5h
	 yi76vg/O/f7fJkaan006rfh7EAhgVk6Efv7S5FZ5Jkf9dkIJpMDXi/oLvPZA9R6MxR
	 nwmKW7QiPpw2pGJ1PDJC7lewZZHJO7soDDQxrObwHRt0jsQ2rbAwStxGh7H62tcYBM
	 +YiPaOXXKyK5Y7CbVFTHB03YmqGR+wRWo3wjcIfrfueF8sFr2eZkGSl5ak+utyrv7j
	 n95YV13w1Q1xg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=android.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=salyzyn@android.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=android.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=android.com header.i=@android.com header.b="ahMJ7+6M"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467t001c8hzDqSR
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2019 00:54:23 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id a93so50753354pla.7
 for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2019 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=android.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=CnI+bcK+PrkZXa0lXxFneGD0jULXut8K+Ere8plo5Kc=;
 b=ahMJ7+6MRm+vSMGaNapJnzEVkJAGqdseEv5NiAiJ2xVM1sgCa/KjV3CzptwbORiRO4
 tdVwxwGBtUsGnUn2c7e13VySsAmWdVDIrtQOwhPmb7DJeeLmPii1ZL4rskNBRvtj47Hs
 RPxCzpXwnaU3g/CUfEBg3QlPGY1SngnQDCYWpuzQB5cndu90bUkPUFPxqy0/Rekd1WQO
 4zngI17UYs23Aiqj3B79lt987Hor3fkgPNT95mLnJes5xZMFhtrjHD+wvpp9CvYS0OOT
 T0Jx+829oyOwsEqr2Xgl3CEpOuwA5/x9WXxEUC4UDChgzDD/d77A140pfqc0MLV3w5Tr
 /pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=CnI+bcK+PrkZXa0lXxFneGD0jULXut8K+Ere8plo5Kc=;
 b=pCbUu2GqUT6mfmjKOCcw91NwlbL1mVyr/dJhm35+5xiUpKLGYSL2gczaGkmdbgSTCp
 /jCK/gy7f7sQX/omzTpg/2gE+HX9mVk4Uq4d0zhnHs2XLnYT8dR7RVkbQpDN8yIDqJJF
 uEFzNL2koyASnMLFWywkGuYe0EUIVF1//x0VZwmQUNH7QTnO4VN4jfbAmJ8QIaME1sOB
 NNEdeIGv9ImwCkmAaS0Ar9S/2G33CaAN9IqeEscW/0J//+6cNEn6dnMW8o+jechvQTBV
 j6opYXe74qqRxoRcSqMXWnc9WQ5i99lJrUyVfn6Qu5/kSsQwy/bv8JnbVjvBNbe9FofW
 CsCA==
X-Gm-Message-State: APjAAAXxXJNDUCc753JGj1CnQcoQ9D7T+Su/vBwvJMidhb3HTq2ntIja
 ufiR6v6W6nabKeTT+pXI/HkTJw==
X-Google-Smtp-Source: APXvYqz3CwepJ0lR8OwKX1IycWhHHs06AM+yzu0iFct+XZq8bOtgfYosWIvv1z0G9d0AAh0UWfDALQ==
X-Received: by 2002:a17:902:3103:: with SMTP id
 w3mr43683432plb.84.1565794459417; 
 Wed, 14 Aug 2019 07:54:19 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com
 ([2620:15c:211:200:5404:91ba:59dc:9400])
 by smtp.googlemail.com with ESMTPSA id
 f20sm144508955pgg.56.2019.08.14.07.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2019 07:54:18 -0700 (PDT)
Subject: Re: [PATCH v2] Add flags option to get xattr method paired to
 __vfs_getxattr
To: Jan Kara <jack@suse.cz>
References: <20190813145527.26289-1-salyzyn@android.com>
 <20190814110022.GB26273@quack2.suse.cz>
Message-ID: <71d66fd1-cc94-fd0c-dfa7-115ba8a6b95a@android.com>
Date: Wed, 14 Aug 2019 07:54:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814110022.GB26273@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Mailman-Approved-At: Thu, 15 Aug 2019 01:14:03 +1000
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
From: Mark Salyzyn via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Mark Salyzyn <salyzyn@android.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dave Kleikamp <shaggy@kernel.org>,
 jfs-discussion@lists.sourceforge.net,
 Phillip Lougher <phillip@squashfs.org.uk>, linux-integrity@vger.kernel.org,
 Martin Brandenburg <martin@omnibond.com>, samba-technical@lists.samba.org,
 Dominique Martinet <asmadeus@codewreck.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mm@kvack.org,
 Chris Mason <clm@fb.com>, netdev@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-xfs@vger.kernel.org,
 Eric Paris <eparis@parisplace.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-afs@lists.infradead.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Mike Marshall <hubcap@omnibond.com>, devel@driverdev.osuosl.org,
 linux-cifs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 Sage Weil <sage@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 linux-unionfs@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 James Morris <jmorris@namei.org>, cluster-devel@redhat.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Vyacheslav Dubeyko <slava@dubeyko.com>,
 Casey Schaufler <casey@schaufler-ca.com>, v9fs-developer@lists.sourceforge.net,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 kernel-team@android.com, devel@lists.orangefs.org,
 Serge Hallyn <serge@hallyn.com>, Eric Van Hensbergen <ericvh@gmail.com>,
 ecryptfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Josef Bacik <josef@toxicpanda.com>, reiserfs-devel@vger.kernel.org,
 Bob Peterson <rpeterso@redhat.com>, Joel Becker <jlbec@evilplan.org>,
 Anna Schumaker <anna.schumaker@netapp.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 selinux@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, David Howells <dhowells@redhat.com>,
 linux-nfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-fsdevel@vger.kernel.org, Artem Bityutskiy <dedekind1@gmail.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>, Steve French <sfrench@samba.org>,
 =?UTF-8?Q?Ernesto_A=2e_Fern=c3=a1ndez?= <ernesto.mnd.fernandez@gmail.com>,
 linux-btrfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 Jan Kara <jack@suse.com>, Tejun Heo <tj@kernel.org>,
 linux-mtd@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>,
 ocfs2-devel@oss.oracle.com, Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 8/14/19 4:00 AM, Jan Kara wrote:
> On Tue 13-08-19 07:55:06, Mark Salyzyn wrote:
> ...
>> diff --git a/fs/xattr.c b/fs/xattr.c
>> index 90dd78f0eb27..71f887518d6f 100644
>> --- a/fs/xattr.c
>> +++ b/fs/xattr.c
> ...
>>   ssize_t
>>   __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
>> -	       void *value, size_t size)
>> +	       void *value, size_t size, int flags)
>>   {
>>   	const struct xattr_handler *handler;
>> -
>> -	handler = xattr_resolve_name(inode, &name);
>> -	if (IS_ERR(handler))
>> -		return PTR_ERR(handler);
>> -	if (!handler->get)
>> -		return -EOPNOTSUPP;
>> -	return handler->get(handler, dentry, inode, name, value, size);
>> -}
>> -EXPORT_SYMBOL(__vfs_getxattr);
>> -
>> -ssize_t
>> -vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
>> -{
>> -	struct inode *inode = dentry->d_inode;
>>   	int error;
>>   
>> +	if (flags & XATTR_NOSECURITY)
>> +		goto nolsm;
> Hum, is it OK for XATTR_NOSECURITY to skip even the xattr_permission()
> check? I understand that for reads of security xattrs it actually does not
> matter in practice but conceptually that seems wrong to me as
> XATTR_NOSECURITY is supposed to skip just security-module checks to avoid
> recursion AFAIU.

Good catch I think.

I was attempting to make this change purely inert, no change in 
functionality, only a change in API. Adding a call to xattr_permission 
would incur a change in overall functionality, as it would introduce 
into the current and original __vfs_getxattr a call to xattr_permission 
that was not there before.

(I will have to defer the real answer and requirements to the security 
folks)

AFAIK you are correct, and to make the call would reduce the attack 
surface, trading a very small amount of CPU utilization, for a much 
larger amount of trust.

Given the long history of this patch set (for overlayfs) and the large 
amount of stakeholders, I would _prefer_ to submit a followup 
independent functionality/security change to _vfs_get_xattr _after_ this 
makes it in.

>
>> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
>> index c1395b5bd432..1216d777d210 100644
>> --- a/include/uapi/linux/xattr.h
>> +++ b/include/uapi/linux/xattr.h
>> @@ -17,8 +17,9 @@
>>   #if __UAPI_DEF_XATTR
>>   #define __USE_KERNEL_XATTR_DEFS
>>   
>> -#define XATTR_CREATE	0x1	/* set value, fail if attr already exists */
>> -#define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
>> +#define XATTR_CREATE	 0x1	/* set value, fail if attr already exists */
>> +#define XATTR_REPLACE	 0x2	/* set value, fail if attr does not exist */
>> +#define XATTR_NOSECURITY 0x4	/* get value, do not involve security check */
>>   #endif
> It seems confusing to export XATTR_NOSECURITY definition to userspace when
> that is kernel-internal flag. I'd just define it in include/linux/xattr.h
> somewhere from the top of flags space (like 0x40000000).
>
> Otherwise the patch looks OK to me (cannot really comment on the security
> module aspect of this whole thing though).

Good point. However, we do need to keep these flags together to reduce 
maintenance risk, I personally abhor two locations for flags bits even 
if one comes from the opposite bit-side; collisions are undetectable at 
build time. Although I have not gone through the entire thought 
experiment, I am expecting that fuse could possibly benefit from this 
flag (if exposed) since it also has a security recursion. That said, 
fuse is probably the example of a gaping wide attack surface if user 
space had access to it ... your xattr_permissions call addition 
requested above would be realistically, not just pedantically, required!

I have to respin the patch because of yet another hole in filesystem 
coverage (I blew the mechanical ubifs adjustment, adjusted the wrong 
function), so please do tell if my rationalizations above hit a note, or 
if I _need_ to make the changes in this patch (change it to a series?).

Thanks -- Mark Salyzyn


